// package
import 'package:flutter/material.dart';
import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// providers
import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';

// widgets
import 'package:hicoffee/widgets/wave.dart';
import 'package:hicoffee/widgets/cardLists.dart';
import 'package:hicoffee/widgets/custom_drawer.dart';
import 'package:hicoffee/widgets/slide_right_route.dart';

// screens
import 'package:hicoffee/screens/search_screen.dart';
import 'package:hicoffee/screens/addItem_screen.dart';



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  Icon customIcon = Icon(Icons.search);
//  bool first = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
//    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
//    if(first){
//      setState(() {
//        first = false;
////        requestsProvider.requestItems();
//      });
//    }
    return Scaffold(
      appBar: _appBar(),
      body: Container(
//        decoration: BoxDecoration(
//            gradient: LinearGradient(
//                begin: Alignment.topLeft,
//                end: Alignment.bottomRight,
//                stops: [
//                  0.2,
//                  0.7,
//                ],
//                colors: [
//                  Theme.of(context).scaffoldBackgroundColor,
//                  Colors.blue[400],
//                ]
//            )
//        ),
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

  Widget setTitle(){
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    if(networkProvider.connection != null){
      if(networkProvider.connection){
        return Text(
          "Hi Coffee",
          style: TextStyle(
              fontSize: 28.0,
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


// TODO: Bug Haye ke Age server ghat bood , ye error bede ro fix konm
// TODO: Delete , Edit , Sell, Add
// TODO: Baad az if haye 200 , ye else ham bezaram ke error ro bege
// TODO: age tedad 0 bood va error 404 dad , liquid refresh ye list khali ro pas bede
// TODO: ye setting bezaram , va toosh option e tedad moghe add ro beshe max esho set kard
// TODO: CountType baraye item beshe set kard
// TODO: age CountType Kiloo Bood , number, double beshe
// TODO: number_selection Change beshe