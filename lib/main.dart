import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter().router;

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ID card scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        debugShowCheckedModeBanner: false,
      routerConfig: _router,

    );
  }
}
