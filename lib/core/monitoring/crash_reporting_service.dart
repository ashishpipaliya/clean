/// Abstract interface for crash reporting.
/// Replace MockCrashReportingService with real Firebase Crashlytics
/// or Sentry implementations when ready.
abstract class CrashReportingService {
  Future<void> initialize();
  Future<void> recordError(dynamic exception, StackTrace? stackTrace, {String? reason, bool fatal = false});
  Future<void> setUserIdentifier(String identifier);
  Future<void> log(String message);
}
