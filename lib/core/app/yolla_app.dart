import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolla/core/config/theme/app_theme.dart';
import 'package:yolla/core/extensions/scroll_extension.dart';
import 'package:yolla/core/l10n/app_localizations.dart';
import 'package:yolla/core/router/app_router.dart';
import 'package:yolla/core/utils/blocs/localization/localization_cubit.dart';
import 'package:yolla/src/presentation/auth/viewmodel/auth_cubit.dart';
import 'package:yolla/src/presentation/qr/viewmodel/qr_cubit.dart';
import 'package:yolla/src/presentation/history/viewmodel/order_cubit.dart';

class YollaUserApp extends StatelessWidget {
  const YollaUserApp({super.key});

  @override
  Widget build(BuildContext context) {
            return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
              create: (context) => QrCubit(),
            ),
            BlocProvider(
              create: (context) => LocalizationCubit(),
            ),
            BlocProvider(
              create: (context) => OrderCubit(),
            ),
          ],
      child: BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            scrollBehavior: NoGlowScrollBehavior(),
            title: 'Yolla user',
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: AppRouter.router,
            theme: AppTheme.themeYolla,
          );
        },
      ),
    );
  }
}
