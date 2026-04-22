import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lamma3ly/app/di/injection.dart';
import 'package:lamma3ly/core/theme/app_theme.dart';
import 'package:lamma3ly/core/localization/locale_cubit.dart';
import 'package:lamma3ly/routing/app_router.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';
import 'package:lamma3ly/l10n/app_localizations.dart';



/// Root application widget.
///
/// Provides global BLoC providers (auth, locale) and configures
/// theming, localization, and routing for the entire app.
class Lamma3lyApp extends StatelessWidget {
  const Lamma3lyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()..checkAutoLogin()),
        BlocProvider(create: (_) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: 'Lamma3ly',
            debugShowCheckedModeBanner: false,

            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,

            // Localization
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Routing
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
