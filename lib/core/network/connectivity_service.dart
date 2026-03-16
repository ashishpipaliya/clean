import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../ui/app_snackbar.dart';

@lazySingleton
class ConnectivityService {
  final InternetConnection _internetConnection;
  final GlobalKey<NavigatorState> _navigatorKey;
  StreamSubscription<InternetStatus>? _subscription;
  bool _hasShownDisconnected = false;

  ConnectivityService(this._internetConnection, this._navigatorKey);

  Future<bool> hasInternetConnection() async {
    return await _internetConnection.hasInternetAccess;
  }

  Stream<InternetStatus> get onStatusChange => _internetConnection.onStatusChange;

  void startMonitoring() {
    _subscription?.cancel();
    _subscription = _internetConnection.onStatusChange.listen((status) {
      final isConnected = status == InternetStatus.connected;

      if (!isConnected && !_hasShownDisconnected) {
        _hasShownDisconnected = true;
        AppSnackbar.showFromKey(
          _navigatorKey,
          'No internet connection',
          type: SnackbarType.error,
          duration: const Duration(seconds: 5),
        );
      } else if (isConnected && _hasShownDisconnected) {
        _hasShownDisconnected = false;
        AppSnackbar.showFromKey(
          _navigatorKey,
          'Internet connection restored',
          type: SnackbarType.success,
        );
      }
    });
  }

  void startListening(void Function(InternetStatus status) onStatusChanged) {
    _subscription?.cancel();
    _subscription = _internetConnection.onStatusChange.listen(onStatusChanged);
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() => stopListening();
}

@module
abstract class ConnectivityModule {
  @lazySingleton
  InternetConnection get internetConnection => InternetConnection.createInstance(
        checkInterval: const Duration(seconds: 3),
        customCheckOptions: [
          InternetCheckOption(uri: Uri.parse('https://www.example.com'))
        ],
      );
}
