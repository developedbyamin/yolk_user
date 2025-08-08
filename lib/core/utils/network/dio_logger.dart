import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioLoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(filter: DevelopmentFilter());

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('REQUEST[${options.method}] => URL: ${options.uri}');
    _logger.d('Request Headers: ${options.headers}');
    _logger.d('Request Data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('RESPONSE[${response.statusCode}] => URL: ${response.requestOptions.uri}');
    _logger.d('Response Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERROR[${err.response?.statusCode}] => URL: ${err.requestOptions.uri}, MESSAGE: ${err.response?.data}',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    super.onError(err, handler);
  }
}
