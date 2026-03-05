import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../navigation/navigation_service.dart';
import '../ui/app_snackbar.dart';

/// Service to check actual internet connectivity
@lazySingleton
class ConnectivityService {
  final InternetConnection _internetConnection;
  final NavigationService _navigationService;
  StreamSubscription<InternetStatus>? _subscription;
  bool _hasShownDisconnected = false;

  ConnectivityService(
    this._internetConnection,
    this._navigationService,
  );

  /// Check if device has internet connection (one-time check)
  Future<bool> hasInternetConnection() async {
    return await _internetConnection.hasInternetAccess;
  }

  /// Get current internet status
  Future<InternetStatus> get currentStatus async {
    final hasInternet = await hasInternetConnection();
    return hasInternet ? InternetStatus.connected : InternetStatus.disconnected;
  }

  /// Listen to internet connectivity changes
  Stream<InternetStatus> get onStatusChange {
    return _internetConnection.onStatusChange;
  }

  /// Start listening to connectivity changes with automatic snackbar notifications
  void startMonitoring() {
    _subscription?.cancel();
    _subscription = _internetConnection.onStatusChange.listen((status) {
      final isConnected = status == InternetStatus.connected;
      final context = _navigationService.currentContext;

      if (context != null) {
        if (!isConnected && !_hasShownDisconnected) {
          _hasShownDisconnected = true;
          AppSnackbar.show(
            context,
            'No internet connection',
            type: SnackbarType.error,
            duration: const Duration(seconds: 5),
          );
        } else if (isConnected && _hasShownDisconnected) {
          _hasShownDisconnected = false;
          AppSnackbar.show(
            context,
            'Internet connection restored',
            type: SnackbarType.success,
          );
        }
      }
    });
  }

  /// Start listening to connectivity changes with custom callback
  void startListening(void Function(InternetStatus status) onStatusChanged) {
    _subscription?.cancel();
    _subscription = _internetConnection.onStatusChange.listen(onStatusChanged);
  }

  /// Stop listening to connectivity changes
  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// Dispose resources
  void dispose() {
    stopListening();
  }
}

@module
abstract class ConnectivityModule {
  @lazySingleton
  InternetConnection get internetConnection => InternetConnection.createInstance(
        checkInterval: const Duration(seconds: 3),
        customCheckOptions: [
          InternetCheckOption(uri: Uri.parse('https://www.google.com')),
          InternetCheckOption(uri: Uri.parse('https://www.cloudflare.com')),
          InternetCheckOption(uri: Uri.parse('https://www.apple.com')),
        ],
      );
}
