import 'package:clean/core/utils/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'crash_reporting_service.dart';

/// Mock implementation — swap with FirebaseCrashReportingService
/// or SentryCrashReportingService when integrating the real SDKs.
@LazySingleton(as: CrashReportingService)
class MockCrashReportingService implements CrashReportingService {
  final AppLogger _logger;

  MockCrashReportingService(this._logger);

  @override
  Future<void> initialize() async {
    _logger.i('[CrashReporting] Mock initialized — replace with Firebase/Sentry');
  }

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    _logger.e(
      '[CrashReporting] ${fatal ? 'FATAL' : 'ERROR'}: ${reason ?? exception}',
      exception,
      stackTrace,
    );
  }

  @override
  Future<void> setUserIdentifier(String identifier) async {
    _logger.d('[CrashReporting] User: $identifier');
  }

  @override
  Future<void> log(String message) async {
    _logger.d('[CrashReporting] $message');
  }
}
