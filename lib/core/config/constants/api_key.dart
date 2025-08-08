class ApiKey {
  // Auth
  static const String baseUrl = 'http://localhost:8080/api/v1';
  static const String authVerifyOtp = '/auth/verify-otp';
  static const String authSendOtp = '/auth/send-otp';
  static const String authRefreshToken = '/auth/send-otp';
  static const String authLogOut = '/auth/logout';
  static const String authValidateToken = '/auth/validate-token';
  static const String authProfile = '/auth/profile';
  static const String authHealth = '/auth/health';
}