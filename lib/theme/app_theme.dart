import 'package:flutter/material.dart';

class AppTheme {
  /*
    _ : membre privé
  */

  ThemeData getTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      ),
      textTheme: TextTheme(
        // style appliqué par défaut à tous les textes
        bodyMedium: TextStyle(fontFamily: 'Arvo'),
        // style à appliquer soi-même
        headlineMedium: TextStyle(
          fontFamily: 'Arvo',
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }
}
