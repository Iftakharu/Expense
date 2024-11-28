import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:from27/screens/expense_screen.dart';

var kColorScheme=ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
var kDarkColorScheme=ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

void main(){
  runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          cardTheme: CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
              )
          ),
        ),
        theme: ThemeData().copyWith(
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer
          ),
          cardTheme: CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal:16,vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer
            )
          ),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorScheme.onSecondaryContainer,
              fontSize: 16
            )
          )
        ),
        home: expense_screen(),
      )
  );
}


