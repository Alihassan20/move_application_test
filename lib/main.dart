import 'package:flutter/material.dart';
import 'package:move_application/presentation/screen/tab_bar.dart';

import 'constant/new_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Move App',
      navigatorKey: navigatorKey,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:  AppTabBar(),
    );
  }
}
