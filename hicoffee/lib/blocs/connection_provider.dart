import 'package:connectivity/connectivity.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hicoffee/model/item.dart';
import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:http/http.dart';
import 'dart:async';
//
//class ConnectionProvider extends ChangeNotifier{
//
//  ConnectionProvider(){
//    initConnectivity();
////    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
////    _connectivitySubscription = _connectivity.onConnectivityChanged;
//  }
//
//
//  final Connectivity _connectivity = Connectivity();
//  String _connectionStatus;
//  Stream<ConnectivityResult> _connectivitySubscription;
//  String get connectionStatus => _connectionStatus;
//
//  set connectionStatus(String connect){
//    _connectionStatus = connect;
//    notifyListeners();
//  }
//
//
//  Future<void> initConnectivity() async {
//    ConnectivityResult result;
//    try {
//      result = await _connectivity.checkConnectivity();
//    } on PlatformException catch (e) {
//      print(e.toString());
//    }
//    return _updateConnectionStatus(result);
//  }
//
//
//  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//    print("*******:  $_connectivitySubscription");
//    switch (result) {
//      case ConnectivityResult.wifi:
//      case ConnectivityResult.mobile:
//      case ConnectivityResult.none:
//        connectionStatus = result.toString();
//        break;
//      default:
//        connectionStatus = 'Failed to get connectivity.';
//        break;
//    }
////    notifyListeners();
//  }
//
//}
//


//
//enum ConnectivityStatus {
//  WiFi,
//  Cellular,
//  Offline
//}
//
//class ConnectivityService{
//  // Create our public controller
//  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();
//
//  ConnectivityService() {
//    // Subscribe to the connectivity Chanaged Steam
//    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//      connectionStatusController.add(_getStatusFromResult(result));
//    });
//  }
//
//  // Convert from the third part enum to our own enum
//  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
//    switch (result) {
//      case ConnectivityResult.mobile:
//        return ConnectivityStatus.Cellular;
//      case ConnectivityResult.wifi:
//        return ConnectivityStatus.WiFi;
//      case ConnectivityResult.none:
//        return ConnectivityStatus.Offline;
//      default:
//        return ConnectivityStatus.Offline;
//    }
//  }
//}

