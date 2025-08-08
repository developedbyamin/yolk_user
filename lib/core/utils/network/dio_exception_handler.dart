import 'package:dio/dio.dart';

class DioExceptionHandler implements Exception {
  static String handleException(DioException error) {
    String errorMessage = "Gözlənilməz xəta baş verdi";

    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          errorMessage = "Yanlış sorğu. Zəhmət olmasa, yenidən cəhd edin.";
          break;
        case 401:
          errorMessage = "İcazəsiz giriş. Zəhmət olmasa, etimadnamələrinizi yoxlayın.";
          break;
        case 403:
          errorMessage = "Qadağan edilib. Bu resursa giriş icazəniz yoxdur.";
          break;
        case 404:
          errorMessage = "Resurs tapılmadı.";
          break;
        case 408:
          errorMessage = "Sorğu vaxtı bitdi. Zəhmət olmasa, bir az sonra yenidən cəhd edin.";
          break;
        case 500:
          errorMessage = "Daxili server xətası. Zəhmət olmasa, bir az sonra yenidən cəhd edin.";
          break;
        default:
          errorMessage = "Gözlənilməz xəta: ${error.response?.statusCode}";
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Bağlantı vaxtı bitdi. Zəhmət olmasa, internet bağlantınızı yoxlayın.";
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = "Göndərmə vaxtı bitdi. Zəhmət olmasa, internet bağlantınızı yoxlayın.";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = "Qəbul vaxtı bitdi. Zəhmət olmasa, yenidən cəhd edin.";
    } else if (error.type == DioExceptionType.cancel) {
      errorMessage = "Sorğu ləğv edildi. Zəhmət olmasa, yenidən cəhd edin.";
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = "İnternet bağlantısı yoxdur. Zəhmət olmasa, bağlantınızı yoxlayın.";
    } else {
      errorMessage = "Gözlənilməz xəta: ${error.message}";
    }

    return errorMessage;
  }
}
