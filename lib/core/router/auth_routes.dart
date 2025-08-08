import 'package:go_router/go_router.dart';
import 'package:yolla/core/router/routes.dart';
import 'package:yolla/src/presentation/auth/views/otp_verify_view.dart';
import 'package:yolla/src/presentation/auth/views/sign_in_view.dart';
import 'package:yolla/src/presentation/checkout/checkout_view.dart';

final List<GoRoute> authRoutes = [
  GoRoute(
    path: Routes.signInView,
    pageBuilder: (context, state) => NoTransitionPage(child: SignInView()),
  ),
  GoRoute(
    path: Routes.otpVerifyView,
    pageBuilder: (context, state){
      final data = state.extra as String;
      return NoTransitionPage(child: OtpVerifyView(phoneNumber: data,));
    },
  ),

];
