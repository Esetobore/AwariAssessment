import 'package:flutter/material.dart';

import '../../shared/widgets/bottom_nav_bar.dart';

/// Wraps any home-level body widget and injects the persistent
/// [AppBottomNavBar].
///
/// In this assessment only the Home tab has a full implementation;
/// the remaining tab bodies (Favourites, Settings, Profile) are
/// architectural placeholders that illustrate how the shell would
/// scale to a multi-tab product.
///
/// The [HomeScreen] composes this shell directly so that the
/// bottom-nav state lives at the screen level and is not shared
/// across unrelated parts of the tree.
class MainNavigationShell extends StatefulWidget {
  final Widget child;

  const MainNavigationShell({super.key, required this.child});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body is provided by the owning screen (HomeScreen)
      // so it can own its own scroll physics and provider scope.
      body: widget.child,
      bottomNavigationBar: AppBottomNavBar(currentIndex: _currentIndex, onTap: (index) => setState(() => _currentIndex = index)),
    );
  }
}
