import 'dart:async';

import 'package:clean/core/di/injection.dart';
import 'package:clean/core/navigation/navigation_service.dart';
import 'package:clean/core/widgets/app_empty_state.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/auth/presentation/view/login_page.dart';
import 'package:clean/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:clean/features/home/presentation/view/pokemon_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bridges a BLoC [Stream] to a [Listenable] for GoRouter's refreshListenable.
class _StreamListenable extends ChangeNotifier {
  late final StreamSubscription<dynamic> _sub;

  _StreamListenable(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

final appRouter = GoRouter(
  navigatorKey: getIt<NavigationService>().navigatorKey,
  initialLocation: LoginPage.routeName,

  // Re-evaluates redirect on every AuthBloc state emission.
  refreshListenable: _StreamListenable(getIt<AuthBloc>().stream),

  // Fully synchronous — reads cached BLoC state, never awaits.
  // Only session states drive navigation; form states are ignored (return null).
  redirect: (context, state) {
    final authState = getIt<AuthBloc>().state;
    final isOnLogin = state.matchedLocation == LoginPage.routeName;

    return authState.when(
      unknown:         () => null,
      authenticated:   () => isOnLogin ? DashboardPage.routeName : null,
      unauthenticated: () => isOnLogin ? null : LoginPage.routeName,
      loading:         () => null,
      loginSuccess:    (_) => null,
      loginFailure:    (_) => null,
      validate:        (_) => null,
    );
  },

  routes: [
    GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.routeName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: DashboardPage.routeName,
      name: DashboardPage.routeName,
      builder: (context, state) => const DashboardPage(),
      routes: [
        GoRoute(
          path: 'pokemon/:id',
          name: 'pokemon-detail',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return PokemonDetailPage(pokemonId: id);
          },
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: AppEmptyState.empty(
      icon: Icons.error,
      title: 'Page not found: ${state.uri}',
    ),
  ),
);
