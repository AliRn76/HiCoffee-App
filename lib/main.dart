import 'package:flutter/material.dart';
import 'package:hicoffee/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    AppBar appBar = AppBar();
//    Widget child = HomeScreen(appBar: appBar);
//    child = CustomGuitarDrawer(child: child);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
//        scaffoldBackgroundColor: Color(0xFFccffff),
//        scaffoldBackgroundColor: Color(0xFFccebff), // abi kam rang
        scaffoldBackgroundColor: Color(0xFFe6f3ff),
//        primaryColor: Color.fromRGBO(212, 244, 255, 1),
//        primaryColor: Color(0xFF80ccff), // abi ye kam por rang
        primaryColor: Color(0xFF99ceff),
        accentColor: Color(0xFF646B86), // 0xFFEB5757 0xFFE8F4F7


      ),
//      home: child,
      home: HomeScreen(),
    );
  }
}
