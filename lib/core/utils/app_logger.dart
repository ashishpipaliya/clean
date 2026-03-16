import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
    // Suppress logs in release mode
    level: const bool.fromEnvironment('dart.vm.product') ? Level.off : Level.trace,
  );

  void d(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  void i(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  void w(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  void e(String message, [Object? error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
