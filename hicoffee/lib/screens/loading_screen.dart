
import 'package:hicoffee/blocs/login_provider.dart';
import 'package:hicoffee/screens/login_screen.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {

  void loading() async{
    Widget child = HomeScreen();
    child = CustomDrawer(child: child);

    bool isToken = await LoginProvider().checkToken();
    if(isToken){
      print("LETS GO TO HomeScreen");
      Future.delayed(Duration(seconds: 5, milliseconds: 150), () {
        Navigator.pushReplacement(
          context,
        MaterialPageRoute(builder: (context) => child),
        );
      });
    }else{
      print("LETS GO TO LoginScreen");
      Future.delayed(Duration(seconds: 5, milliseconds: 150), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loading();
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
