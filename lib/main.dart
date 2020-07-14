import 'package:flutter/material.dart';
import 'package:hicoffee/screens/loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        scaffoldBackgroundColor: Color(0xFFccffff),
        scaffoldBackgroundColor: Color(0xFFccebff),
//        primaryColor: Color.fromRGBO(212, 244, 255, 1),
        primaryColor: Color(0xFF80ccff),
        accentColor: Color(0xFF646B86), // 0xFFEB5757 0xFFE8F4F7


      ),
      home: LoadingScreen(),
    );
  }
}
