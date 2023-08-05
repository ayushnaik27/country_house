import 'package:flutter/material.dart';

import 'Screens/AllCountries.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        // scaffoldBackgroundColor: Colors.black54,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: AllCountries(),
    ),
  );
}


