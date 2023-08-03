import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color.fromRGBO(255, 255, 255, 1);
  static const Color primaryDark = Color.fromARGB(255, 11, 44, 78);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      //Color primario
      primaryColor: const Color.fromARGB(255, 11, 44, 78),

      //AppBarTheme
      appBarTheme: const AppBarTheme(
        color: primaryDark,
        elevation: 2,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: primaryLight),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryLight, elevation: 5),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppTheme.primaryLight,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primaryLight),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryLight),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryLight),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10))),
      ));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //Color primario
    primaryColor: Colors.indigo,

    //AppBarTheme
    appBarTheme: const AppBarTheme(
      color: primaryDark,
      elevation: 2,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: primaryDark),
    ),

    scaffoldBackgroundColor: Colors.black,
  );
}
