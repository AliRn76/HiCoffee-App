// package
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
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

  // Collection Data

  Icon customIcon = Icon(Icons.search);
  Widget customTitle = Text(
    "Hi Coffee",
    style: TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  );

  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'home',
        title: 'Home',
      ),
      new MenuItem(
        id: 'nightmode',
        title: 'Night Mode',
      ),
      new MenuItem(
        id: 'terms',
        title: 'Terms of Service',
      ),
      new MenuItem(
        id: 'about',
        title: 'About us',
      ),
    ],
  );

  // End of Collecting Data



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
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


  Widget _appBar(){
    final RequestsProvider getItems = Provider.of<RequestsProvider>(context);
    return AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: customTitle,
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
                      pageBuilder: (_, __, ___) => SearchScreen(list: getItems.items)
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
    return Align(
      alignment: Alignment(0.9, 0.95),
      child: FloatingActionButton(
        splashColor: Colors.blue,
        onPressed: (){
          setState(() {
            Navigator.push(
              context,
              SlideRightRoute(page: AddItemScreen(list: getItems.items)),
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
