import 'package:flutter/material.dart';

class CustomTheme {
  static const Color grey = Color.fromARGB(255, 206, 203, 203);
  static const Color blue = Color.fromARGB(255, 57, 158, 239);
  static const cardShadow = [
    BoxShadow(
        color: grey, blurRadius: 15, spreadRadius: 0.2, offset: Offset(0, 3))
  ];

  static GetcardDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      boxShadow: cardShadow,
    );
  }

  static const buttonShadow = [
    BoxShadow(
        color: grey, blurRadius: 7, spreadRadius: 0.2, offset: Offset(0, 3))
  ];
  static ThemeData getTheme() {
    Map<String, double> fontSize = {
      "sm": 14,
      "md": 18,
      "lg": 24,
    };
    return ThemeData(
        primaryColor: blue,

        // app bar theme
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            toolbarHeight: 70,
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: fontSize["lg"],
                fontWeight: FontWeight.bold)),
        fontFamily: "Poppins",

        // tab bar theme
        tabBarTheme:
            TabBarTheme(labelColor: blue, unselectedLabelColor: Colors.black),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: Colors.black,
              fontSize: fontSize['lg'],
              fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Colors.black,
              fontSize: fontSize['md'],
              fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(
              color: Colors.black,
              fontSize: fontSize['sm'],
              fontWeight: FontWeight.bold),
          bodySmall: TextStyle(
              fontSize: fontSize['sm'], fontWeight: FontWeight.normal),
          titleSmall: TextStyle(
              fontSize: fontSize['sm'],
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ));
  }
}
