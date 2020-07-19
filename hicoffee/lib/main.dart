import 'package:flutter/material.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:hicoffee/screens/home_screen.dart';
import 'package:hicoffee/screens/loading_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child = LoadingScreen();
    child = CustomDrawer(child: child);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RequestsProvider>.value(
            value: RequestsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'HiCoffee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFe6f3ff),
          primaryColor: Color(0xFF66c2ff),
          accentColor: Color(0xFF646B86),
        ),
        home: child,
      ),
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



