import 'package:flutter/material.dart';
import 'package:hicoffee/screens/home_screen.dart';
import 'package:hicoffee/screens/loading_screen.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => CustomDrawer.of(context).open(),
          );
        },
      ),
      title: Text('Hello Flutter Europe'),
    );
    Widget child = LoadingScreen();
    child = CustomDrawer(child: child);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFe6f3ff),
        primaryColor: Color(0xFF66c2ff),
        accentColor: Color(0xFF646B86),
      ),
      home: child,
    );


//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        scaffoldBackgroundColor: Color(0xFFe6f3ff),
//        primaryColor: Color(0xFF66c2ff),
//        accentColor: Color(0xFF646B86),
//      ),
//      home: LoadingScreen(),
//    );
  }
}



