import 'package:flutter/material.dart';

import '../../feature/entry/presentation/screens/entry_screen.dart';
import '../../feature/home/domain/entities/product.dart';
import '../../feature/home/presentation/screens/home_screen.dart';
import '../../feature/home/presentation/screens/product_screen.dart';
import 'route_enum.dart';

/// Central route factory consumed by [MaterialApp.onGenerateRoute].
abstract final class RouteConfig {
  RouteConfig._();

  static String initial = RouteEnum.entry.path;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = RouteEnum.fromPath(settings.name);
    // Entry (splash / landing)
    switch (route) {
      case RouteEnum.entry:
        return _fade(settings, const EntryScreen());

      // Home (product catalogue)
      case RouteEnum.home:
        return _fade(settings, const HomeScreen());

      //Product detail
      case RouteEnum.product:
        assert(settings.arguments is Product, 'ProductScreen requires a Product argument via Navigator.pushNamed');
        final product = settings.arguments as Product;
        return _slideFromRight(settings, ProductScreen(product: product));

      //Fallback
      default:
        return _fade(settings, const EntryScreen());
    }
  }

  // Private helpers

  static PageRouteBuilder<T> _fade<T>(RouteSettings s, Widget page) {
    return PageRouteBuilder<T>(
      settings: s,
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) => FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      ),
    );
  }

  static PageRouteBuilder<T> _slideFromRight<T>(RouteSettings s, Widget page) {
    return PageRouteBuilder<T>(
      settings: s,
      transitionDuration: const Duration(milliseconds: 380),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic);
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(curved),
          child: FadeTransition(opacity: Tween<double>(begin: 0.6, end: 1).animate(curved), child: child),
        );
      },
    );
  }
}
