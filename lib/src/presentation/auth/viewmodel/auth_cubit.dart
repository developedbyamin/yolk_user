import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:yolla/core/utils/storage/secure_storage.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  AuthCubit() : super(AuthInitial()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    emit(AuthLoading());
    try {
      final AuthTokens? tokens = await SecureStorage.getTokens();
      if (tokens == null || tokens.refreshToken.isEmpty) {
        emit(Unauthenticated());
        return;
      }
      final bool isExpired = JwtDecoder.isExpired(tokens.refreshToken);
      emit(isExpired ? Unauthenticated() : Authenticated());
    } catch (e, stackTrace) {
      debugPrint("Error while checking token: $e\n$stackTrace");
      emit(Unauthenticated());
    }
  }
}
