import 'package:clean/core/monitoring/app_bloc_observer.dart';
import 'package:clean/core/monitoring/crash_reporting_service.dart';
import 'package:clean/core/utils/app_logger.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/injection.dart';
import 'core/network/connectivity_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await getIt<CrashReportingService>().initialize();
  Bloc.observer = AppBlocObserver(getIt<AppLogger>(), getIt<CrashReportingService>());
  getIt<ConnectivityService>().startMonitoring();

  // Fire initialize and wait for AuthBloc to resolve auth state from storage
  // BEFORE runApp. This runs while the native splash is still showing,
  // so the router's first redirect is already synchronous — no login flash.
  final authBloc = getIt<AuthBloc>()..add(const AuthEvent.initialize());
  await authBloc.stream.firstWhere(
    (s) => s.whenOrNull(unknown: () => true) == null,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AppLogger _logger = getIt<AppLogger>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _logger.d('[Lifecycle] ${state.name.toUpperCase()}');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<SettingsBloc>()),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Clean',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
            ],
            locale: state.locale,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
