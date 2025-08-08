import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:yolla/core/utils/storage/secure_storage.dart';

class AppInterceptor extends Interceptor {
  final Dio _dio;

  AppInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AuthTokens? tokens = await SecureStorage.getTokens();
    if (tokens?.accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${tokens!.accessToken}';
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    bool isRefreshRequest = err.requestOptions.path == 'https://test.mealper.com/api/auth/v-1.0.0/public/token-refresh';
    if (err.response?.statusCode == 401 && !isRefreshRequest) {
      await _handleTokenRefresh(err, handler);
    } else {
      return handler.next(err);
    }
  }

  Future<void> _handleTokenRefresh(DioException err, ErrorInterceptorHandler handler) async {
    try {
      AuthTokens? tokens = await SecureStorage.getTokens();
      if (tokens?.refreshToken != null) {
        String? newAccessToken = await refreshAccessToken(tokens!.refreshToken);
        if (newAccessToken != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          return handler.resolve(await _retryRequest(err.requestOptions));
        }
      }
    } catch (e) {
      debugPrint("Exception during token refresh: $e");
    }
    return handler.next(err);
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    try {
      final dioWithoutInterceptor = Dio();

      final response = await dioWithoutInterceptor.post(
        'https://test.mealper.com/api/auth/v-1.0.0/public/token-refresh',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        String newAccessToken = response.data['accessToken'];
        AuthTokens? oldTokens = await SecureStorage.getTokens();
        AuthTokens tokens = AuthTokens(accessToken: newAccessToken, refreshToken: oldTokens!.refreshToken);
        await SecureStorage.saveTokens(tokens);
        return newAccessToken;
      } else {
        debugPrint("Failed to refresh access token. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error refreshing access token: $e");
    }
    return null;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    return _dio.fetch(requestOptions);
  }
}
