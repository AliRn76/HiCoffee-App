import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_button/progress_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';

import 'package:hicoffee/screens/home_screen.dart';

import 'package:hicoffee/sqlite/database_helper.dart';

import 'package:hicoffee/widgets/custom_drawer.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color kPrimaryColor = Color(0xFF66c2ff);
  String username;
  String password;
  ButtonState buttonState = ButtonState.normal;
  String buttonText = "LOGIN";
  Color buttonColor = Color(0xFF66c2ff);
  bool obscureText = true;

  void login(networkProvider) async{
//    LogsProvider logsProvider = LogsProvider();
//    RequestsProvider requestsProvider = RequestsProvider();
    Widget child = HomeScreen();
    child = CustomDrawer(child: child);
    String token;
    var reqBody = Map<String, dynamic>();
    reqBody['username'] = username;
    reqBody['password'] = password;
    if(username == null || username.isEmpty)
      return;
    if(password == null || password.isEmpty)
      return;
    if(networkProvider.connection == false){
      setState((){
        buttonState = ButtonState.error;
        buttonColor = Colors.red[400];
        buttonText = "No Connection";
      });
      Future.delayed(Duration(milliseconds: 700), () {
        setState(() => buttonColor = Color(0xFF66c2ff));
        buttonText = "LOGIN";
      });
      return;
    }
    setState(() => buttonState = ButtonState.inProgress);
    String jsonBody = jsonEncode(reqBody);
    print(jsonBody);
    Map<String, String> reqHeader = {"Content-type": "application/json", "Accept": "application/json"};
    Response response = await post("http://al1.best:85/api/login/", body:jsonBody, headers: reqHeader);
    dynamic data = await jsonDecode(utf8.decode(response.bodyBytes));
    token = data["token"];
    print("Login statusCode: ${response.statusCode}");
    if(response.statusCode == 200){
      // Update the local db
      var result = await DatabaseHelper().insertToken(token);
      print("insert Token to db: $result");
      // Send startup requests again
//      logsProvider.reqShowLogs();
//      requestsProvider.requestItems();
      // Go to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => child),
      );
    }else{
      setState((){
        buttonState = ButtonState.error;
        buttonColor = Colors.red[400];
        buttonText = "Username or Password was Incorrect";
      });
      Future.delayed(Duration(seconds: 3), () {
        setState(() => buttonColor = Color(0xFF66c2ff));
        buttonText = "LOGIN";
      });
    }
  }


  void showPassword(){
    setState(() => obscureText = false);
    Future.delayed(Duration(seconds: 1), () {
      setState(() => obscureText = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              top: 40,
              child: Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Align(
                    alignment: Alignment(0.65,0),
                    child: Image.asset(
                      "assets/images/login_logo.png",
                      height: size.height * 0.30,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onChanged: (value) => setState(() => username = value),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Username",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    obscureText: obscureText,
                    onChanged: (value) => setState(() => password = value),
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () => showPassword(),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: ProgressButton(
                      child: loginChild(),
                      onPressed: () => login(networkProvider),
                      buttonState: buttonState,
                      backgroundColor: buttonColor,
                    ),
                  ),
                ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginChild(){
    if(buttonState == ButtonState.inProgress){
      return SpinKitDualRing(
        color: Colors.white,
        size: 20.0,
      );
    }else{
      return Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      );
    }
  }
}
