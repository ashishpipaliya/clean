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
  
  // Start connectivity monitoring
  getIt<ConnectivityService>().startMonitoring();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
    
    switch (state) {
      case AppLifecycleState.detached:
        // All views have been detached from the application, and the application is about to exit.
        print('🔴 App Lifecycle: DETACHED');
      case AppLifecycleState.resumed:
        // The application is visible and responding to user input.
        print('🟢 App Lifecycle: RESUMED');
      case AppLifecycleState.inactive:
        // The application is in an inactive state and is not receiving user input.
        print('🟡 App Lifecycle: INACTIVE');
      case AppLifecycleState.paused:
        // The application is not currently visible to the user, not responding to user input, and running in the background.
        print('🟠 App Lifecycle: PAUSED');
      case AppLifecycleState.hidden:
        // The application is still hosted on a flutter engine but is detached from any host views.
        print('⚫ App Lifecycle: HIDDEN');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsBloc>(),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter Clean',
            
            // Theme Configuration
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            
            // Localization Configuration
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('hi'), // Hindi
            ],
            locale: state.locale,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
