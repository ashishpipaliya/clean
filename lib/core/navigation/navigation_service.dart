import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// Service for global navigation operations
@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationService(this.navigatorKey);

  /// Get current context
  BuildContext? get currentContext => navigatorKey.currentContext;

  /// Get current state
  NavigatorState? get currentState => navigatorKey.currentState;

}

@module
abstract class NavigationModule {
  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}
