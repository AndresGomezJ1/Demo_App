import 'package:flutter/material.dart';
import 'package:movie_app/core/resources/app_theme.dart';
import 'package:movie_app/core/resources/app_router.dart';

import 'core/resources/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: getApplicationTheme(),
      routerConfig: AppRouter().router,
    );
  }
}