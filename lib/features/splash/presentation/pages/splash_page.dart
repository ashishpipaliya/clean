import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with scale and fade animation
            Icon(
              Icons.flutter_dash,
              size: 120,
              color: Colors.white,
            )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                )
                .fadeIn(duration: 400.ms),
            
            const SizedBox(height: 32),
            
            // App title with slide and fade animation
            Text(
              l10n.appTitle,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            )
                .animate()
                .slideY(
                  duration: 500.ms,
                  begin: 0.3,
                  end: 0,
                  curve: Curves.easeOut,
                  delay: 200.ms,
                )
                .fadeIn(duration: 400.ms, delay: 200.ms),
            
            const SizedBox(height: 48),
            
            // Loading indicator with fade animation
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withValues(alpha: 0.8),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms, delay: 600.ms)
                .scale(
                  duration: 400.ms,
                  delay: 600.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }
}
