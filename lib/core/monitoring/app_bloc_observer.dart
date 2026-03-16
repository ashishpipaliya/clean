import 'package:clean/core/monitoring/crash_reporting_service.dart';
import 'package:clean/core/utils/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  final AppLogger _logger;
  final CrashReportingService _crashReporting;

  AppBlocObserver(this._logger, this._crashReporting);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.d('[BLoC] Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.d('[BLoC] Event: ${bloc.runtimeType} → $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.d('[BLoC] Change: ${bloc.runtimeType}\n  current: ${change.currentState}\n  next: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.d('[BLoC] Transition: ${bloc.runtimeType} via ${transition.event}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _logger.e('[BLoC] Error in ${bloc.runtimeType}', error, stackTrace);
    _crashReporting.recordError(error, stackTrace, reason: 'BLoC error in ${bloc.runtimeType}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.d('[BLoC] Closed: ${bloc.runtimeType}');
  }
}
