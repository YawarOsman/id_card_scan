import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      useMaterial3: true,
    );
