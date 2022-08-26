import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    return ThemeData(
        snackBarTheme: SnackBarThemeData(backgroundColor: Colors.orange[800]),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.orange[800],
            secondary: Colors.orange[800],
            brightness: Brightness.dark),
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        indicatorColor: const Color(0xff0E1D36),
        hintColor: Colors.white,
        highlightColor: const Color(0xff372901),
        hoverColor: const Color(0xff3A3A3B),
        focusColor: const Color(0xff0B2512),
        disabledColor: Colors.grey,
        cardColor: const Color(0xFF151515),
        canvasColor: Colors.black,
        brightness: Brightness.dark,
        // errorColor: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.all(20),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                borderSide: BorderSide(width: 2, color: Colors.red)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                borderSide: BorderSide(
                    width: 2, color: Color.fromRGBO(239, 108, 0, 1))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(45)))),
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(foregroundColor: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.black))));
  }
}
