import 'package:flutter/material.dart';


class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Text(
          "Log",
        ),
      ),
    );
  }

  Widget _appBar(){
    return AppBar(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Log",
        style: TextStyle(
          fontSize: 28.0,
          fontFamily: "Waltograph",
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}
