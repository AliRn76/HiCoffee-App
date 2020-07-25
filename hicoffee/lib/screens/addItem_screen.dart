import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/screens/search_screen.dart';
import 'package:hicoffee/sqlite/database_helper.dart';
import 'package:hicoffee/widgets/wave.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:hicoffee/model/item_model.dart';
//import 'package:loading_text/loading_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddItemScreen extends StatefulWidget {
  List<Item> list = [];
  bool connection;
  AddItemScreen({this.list, this.connection});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  GlobalKey<FlipCardState> addCardKey = GlobalKey<FlipCardState>();
  TextEditingController nameController = TextEditingController();
  Icon customIcon = Icon(Icons.search);
  double _value = 0;
  String responseMessage = "لطفا صبر کنید";
  Color responseColor = Colors.black;
  Icon responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
  double height() => MediaQuery.of(context).size.height;
  double width() => MediaQuery.of(context).size.width;


  void tryAddItem(requestsProvider, networkProvider, logsProvider) async{
    int statusCode;
    Item item = Item(nameController.text, _value.toInt());
    if(networkProvider.connection == false){
      setState(() {
        responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
        responseMessage = "ابتدا به اینترنت متصل شوید";
        responseColor = Colors.redAccent[400];
        responseIcon = Icon(Icons.close, color: responseColor);
      });
    }else{
      setState(() {
        responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
        responseMessage = "لطفا صبر کنید";
        responseColor = Color(0xFF66c2ff);
      });
    }
    if(item.name == ''){
      setState(() {
        responseMessage = "ابتدا نام محصول را پر کنید";
        responseColor = Colors.redAccent[400];
        responseIcon = Icon(Icons.close, color: responseColor);
      });
    }else{
      print(item.name );
      print(item.number);
      statusCode = await requestsProvider.reqAddItem(item);
      print(statusCode);
      setState(() {
        if(statusCode == 201){
          responseMessage = "باموفقیت اضافه شد";
          responseColor = Colors.greenAccent[400];
          responseIcon = Icon(Icons.done_all, color: responseColor);
          nameController.clear();
          _value = 0;
          logsProvider.reqShowLogs();
        }else if(statusCode == 406){
          responseMessage = "نام محصول تکراری است";
          responseColor = Colors.redAccent[400];
          responseIcon = Icon(Icons.close, color: responseColor);
        }
        else{
          responseMessage = "یه چیزی این وسط اشتباه کار میکنه - خطا $statusCode";
          responseColor = Colors.redAccent[400];
          responseIcon = Icon(Icons.clear, color: responseColor);
        }
      });
    }
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor ,
        child: Stack(
          children: <Widget>[
            Center(
              child: FlipCard(
                flipOnTouch: false,
                key: addCardKey,
                direction: FlipDirection.VERTICAL,
                front: _frontView(),
                back: _backView(),
              ),
            ),
            Wave(),
          ],
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
        title: setTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 600),
                    pageBuilder: (_, __, ___) => SearchScreen(  )
                ),
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => SearchScreen(list: list)),
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

  Widget _frontView(){
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: height()/5),
        height: height() - height()/1.9,
        width: width()- width()/2.5,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 7.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: "BNazanin",
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "نام محصول",
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 7.0),
              child: FluidSlider(
                labelsTextStyle: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                value: _value,
                valueTextStyle: TextStyle(
                  fontSize: 16.0,
                ),
                onChanged: (double newValue) {
                  setState(() {
                    _value = newValue;
                  });
                },
                min: 0.0,
                max: 100.0,
              ),
            ),
            SizedBox(height: height()/12),
            Container(
              child: Center(
                child: ClayContainer(
                  emboss: false,
                  curveType: CurveType.none,
                  borderRadius: 12.0,
//                  color: baseColor,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 70,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      onPressed: () {
                        tryAddItem(requestsProvider, networkProvider, logsProvider);
                        return addCardKey.currentState.toggleCard();
                      },
                    child: Text(
                      "ثبت",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "BNazanin",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backView(){
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: height()/17),
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(
            color: responseColor,
            width: 1.0,
          ),
        ),
        height: height() - height()/1.4,
        width: width() - width()/2.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: height()/20),
            Text(
              responseMessage,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "BNazanin",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height()/12),
            Container(
              child: Center(
                child: ClayContainer(
                  borderRadius: 12.0,
//                  color: baseColor,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 70,
                  child: IconButton(
                    onPressed: () => addCardKey.currentState.toggleCard(),
                    icon: responseIcon,
                  ),
                ),
              ),
            ),
            SizedBox(height: height()/50),
          ],
        ),
      ),
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
              //      fontWeight: FontWeight.bold,
              fontFamily: "Waltograph"
          ),
        );
      }else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle(
              color: Colors.black,
              size: 20.0,
            ),
            Text(
              "  Connecting",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontFamily: "BNazanin‌‌",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );

      }
    }
  }
}
