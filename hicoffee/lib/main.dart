import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/blocs/login_provider.dart';
import 'package:hicoffee/blocs/logs_provider.dart';

import 'package:hicoffee/screens/loading_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LogsProvider>.value(value: LogsProvider()),
        ChangeNotifierProvider<LoginProvider>.value(value: LoginProvider()),
        ChangeNotifierProvider<NetworkProvider>.value(value: NetworkProvider()),
        ChangeNotifierProvider<RequestsProvider>.value(value: RequestsProvider()),
        /// Sample of Stream Provider
//        StreamProvider<ConnectivityResult>.value(
//          value: NetworkProvider().networkStatusController.stream,
//        ),
      ],
      child: MaterialApp(
        title: 'Hi Coffee',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFe6f3ff),
          primaryColor: Color(0xFF66c2ff),
          accentColor: Color(0xFF646B86),
        ),
        home: LoadingScreen(),
      ),
    );
  }
}



