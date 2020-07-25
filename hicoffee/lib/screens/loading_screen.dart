
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    print("Loading initState");
    loading();
  }


  void loading() async{
    Widget child = HomeScreen();
    child = CustomDrawer(child: child);
    Future.delayed(Duration(seconds: 5, milliseconds: 150), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => child),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/gifs/coffee.gif"),
      ),
    );
  }
}
