import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/navigation/route_config.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awari Assessment',
      theme: AppTheme.light,
      initialRoute: RouteConfig.initial,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
