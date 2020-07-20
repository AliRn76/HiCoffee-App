// package
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'package:loading_text/loading_text.dart';
import 'dart:async';

import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
// model
import 'package:hicoffee/model/item.dart';
// widgets
import 'package:hicoffee/widgets/wave.dart';
import 'package:hicoffee/widgets/cardLists.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:hicoffee/widgets/slide_right_route.dart';
// screens
import 'package:hicoffee/screens/search_screen.dart';
import 'package:hicoffee/screens/addItem_screen.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:hicoffee/sqlite/database_helper.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
//  final Connectivity _connectivity = Connectivity();
//  String _connectionStatus;
//  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Icon customIcon = Icon(Icons.search);
//  bool connection;

  final menu = Menu(
    items: [
      MenuItem(id: 'home',      title: 'Home'),
      MenuItem(id: 'nightmode', title: 'Night Mode'),
      MenuItem(id: 'terms',     title: 'Terms of Service'),
      MenuItem(id: 'about',     title: 'About us'),
    ],
  );




  @override
  void initState() {
    super.initState();
//    initConnectivity();
//    _connectivitySubscription =
//        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
//    _connectivitySubscription.cancel();
    super.dispose();
  }

//  Future<void> initConnectivity() async {
//    ConnectivityResult result;
//    try {
//      result = await _connectivity.checkConnectivity();
//    } on PlatformException catch (e) {
//      print(e.toString());
//    }
//    if (!mounted) {
//      return Future.value(null);
//    }
//    return _updateConnectionStatus(result);
//  }


//  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//    switch (result) {
//      case ConnectivityResult.wifi:
//      case ConnectivityResult.mobile:
//      case ConnectivityResult.none:
//        setState(() => _connectionStatus = result.toString());
//        break;
//      default:
//        setState(() => _connectionStatus = 'Failed to get connectivity.');
//        break;
//    }
//  }




  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
//    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: <Widget>[
            Center(child: CardLists(list: requestsProvider.items)),
            Wave(),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }


//  @override
//  Widget build(BuildContext context) {
//    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
//    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
//    return StreamProvider<ConnectivityResult>.value(
//      value: networkProvider.networkStatusController.stream,
//      child: Consumer<ConnectivityResult>(
//        builder: (context, value, _){
//          if(value == null){
//            return Text(
//                "YOU ARE ONLINE"
//            );
//          }else{
//            return Text(
//                "YOU ARE OFFLINE"
//            );
//          }
//        },
//      ),
//    );
//  }




//  Widget setTitle(ConnectivityService connectivityService){
//    print(connectivityService.connectionStatusController.stream);
  Widget setTitle(){
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    if(networkProvider.connection != null){
      if(networkProvider.connection){
        return Text(
          "Hi Coffee",
          style: TextStyle(
              fontSize: 28.0,
              //      fontWeight: FontWeight.bold,
              fontFamily: "Waltograph"
          ),
        );
      }else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Connecting  ",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: "Aria",
                fontWeight: FontWeight.w500,
              ),
            ),
            SpinKitFadingCircle(
              color: Colors.black,
              size: 20.0,
            ),
          ],
        );
      }
    }
  }

  Widget _appBar(){
      return AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: setTitle(),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => CustomDrawer.of(context).open(),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 600),
                      pageBuilder: (_, __, ___) => SearchScreen()
                  ),
              );
            },
            icon: Hero(
              tag: "search",
              child: customIcon
            ),
          ),
        ]
    );
  }

  Widget _floatingActionButton(){
    final RequestsProvider getItems = Provider.of<RequestsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    return Align(
      alignment: Alignment(0.9, 0.95),
      child: FloatingActionButton(
        splashColor: Colors.blue,
        onPressed: (){
          setState(() {
            Navigator.push(
              context,
              SlideRightRoute(page: AddItemScreen(list: getItems.items, connection: networkProvider.connection,)),
            );
          });
        },
        elevation: 20.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)
            )
        ),
        child: Icon(
          Icons.add,
          size: 36.0,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }



}


//TODO: Edit & Delete Jofteshon Bayad Ye Flip Card Bashan Va Hamonja Poshte Card Ha Edit Ya Deleteshon Kone


//TODO: Edit Moonde
//TODO: Item haye Drawer Moonde


//TODO: Jaye number selection mishe az number picker estefade kard
//TODO: hamon position payinish faghat bargarde va poshtesh beshe item ro edit ya delete kard