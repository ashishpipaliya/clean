import 'package:clean/features/home/presentation/view/home_page.dart';
import 'package:clean/features/settings/presentation/view/settings_page.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = "/dashboard";

  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);

  final List<Widget> _pages = const [HomePage(), SettingsPage()];

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          return _pages[currentIndex];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndexNotifier,
        builder: (context, currentIndex, child) {
          final l10n = AppLocalizations.of(context)!;
          return NavigationBar(
            selectedIndex: currentIndex,
            indicatorColor: Theme.of(context).colorScheme.primary,
            onDestinationSelected: (index) {
              _currentIndexNotifier.value = index;
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: l10n.home,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: l10n.settings,
              ),
            ],
          );
        },
      ),
    );
  }
}
