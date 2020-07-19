import 'dart:convert';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/model/item.dart';
import 'package:hicoffee/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:hicoffee/sqlite/database_helper.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  List<Item> items;


  
  @override
  void initState() {
//    final GetItems getItems = Provider.of<GetItems>(context, listen: false);
//    // Use the local db
//    getItems.selectAll();
//    // Get data from server
//    getItems.requestItems();
    super.initState();
    print("Loading initState");
    loading();
  }

  void loading() async{
    Widget child = HomeScreen();
    child = CustomDrawer(child: child);
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => child),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
