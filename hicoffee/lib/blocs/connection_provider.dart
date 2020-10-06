import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';



class NetworkProvider extends ChangeNotifier{

  NetworkProvider(){
    initConnectivity();
    _invokeNetworkStatusListen();
  }

  StreamSubscription<ConnectivityResult> _subscription;
  bool _connection;

  StreamSubscription<ConnectivityResult> get subscription => _subscription;
  bool get connection => _connection;


  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if(result.toString() == "ConnectivityResult.none")
//        _connection = false;
      /// Make It Offline
      _connection = true;
    else
      _connection = true;
    notifyListeners();
  }


  void _invokeNetworkStatusListen() async{
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("RESULT: $result");
      if(result.toString() == "ConnectivityResult.none")
//        _connection = false;
        /// Make It Offline
        _connection = true;
      else
        _connection = true;
      notifyListeners();
    });
  }


  void disposeStreams(){
    _subscription.cancel();
  }
}














