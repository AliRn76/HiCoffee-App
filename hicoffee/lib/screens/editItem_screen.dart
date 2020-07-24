import 'dart:ui';

import 'package:clay_containers/clay_containers.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:hicoffee/blocs/connection_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/model/item.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  Item item;
  EditItemScreen({this.item});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> editCardKey = GlobalKey<FlipCardState>();
    TextEditingController nameController = TextEditingController(text: widget.item.name);
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    Color acceptColor = Colors.greenAccent[200];
    Color deleteColor = Colors.redAccent[400];
    Color editColor = Colors.grey[600];
    int _value = widget.item.number;
    String responseMessage = "لطفا صبر کنید";
    Color responseColor = Theme.of(context).primaryColor;
    Icon responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
    double height() => MediaQuery.of(context).size.height;
    double width() => MediaQuery.of(context).size.width;




    void tryEditItem(RequestsProvider requestsProvider, NetworkProvider networkProvider ,StateSetter setter) async{
      int statusCode;
      String old_name = widget.item.name;
      String name = nameController.text;
      int number = _value;
      print(old_name);
      print(name);
      print(number);
//      if (name == old_name)
//        name = null;
      if(networkProvider.connection == false){
        setter(() {
          responseMessage = "ابتدا به اینترنت متصل شوید";
          responseColor = Colors.redAccent[400];
          responseIcon = Icon(Icons.close, color: responseColor);
        });
      }else{
        setter(() {
          responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
          responseMessage = "لطفا صبر کنید";
          responseColor = Color(0xFF66c2ff);
        });
      }
      if(name == ''){
        setter(() {
          responseMessage = "ابتدا نام محصول را پر کنید";
          responseColor = Colors.redAccent[400];
          responseIcon = Icon(Icons.close, color: responseColor);
        });
      }else{
        statusCode = await requestsProvider.reqEditItem(old_name, name, number);
        print("Edit statusCode: $statusCode");
        setter(() {
          if(statusCode == 202){
            print("tooye 202");
//            _snackBar(responseMessage, responseColor);
            return Navigator.pop(context, true);
//            Scaffold.of(context).showSnackBar(_snackBar(responseMessage, responseColor));
//            responseMessage = "باموفقیت ویرایش شد";
//            responseColor = Colors.greenAccent[400];
//            responseIcon = Icon(Icons.done_all, color: responseColor);
          }else if(statusCode == 406){

            responseMessage = "نام محصول تکراری است";
            responseColor = Colors.redAccent[400];
            responseIcon = Icon(Icons.close, color: responseColor);
          }
          else{
            responseMessage = "یه چیزی این وسط اشتباه کار میکنه \n خطا $statusCode";
            responseColor = Colors.redAccent[400];
            responseIcon = Icon(Icons.clear, color: responseColor);
          }
        });
      }
    }


    return SingleChildScrollView(
      child: Center(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setter){
            return FlipCard(
              flipOnTouch: false,
              key: editCardKey,
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                width: width()/2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "BNazanin",
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height()/30),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10.0),
                          Text(
                            "تعداد: ",
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                          Container(
                            height: 50,
                            child: NumberPicker.horizontal(
                                initialValue: widget.item.number,
                                highlightSelectedValue: false,
                                minValue: 0,
                                maxValue: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(color: Colors.blue[400], width: 1.3, )
                                ),
                                onChanged: (newValue) =>
                                    setter(() => _value = newValue)
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height()/30),
                    Container(
                      child: Center(
                        child: ClayContainer(
                          emboss: false,
                          curveType: CurveType.none,
                          borderRadius: 12.0,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 70,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              onPressed: () {
                                tryEditItem(requestsProvider, networkProvider, setter);
                                return editCardKey.currentState.toggleCard();
                              },
                              child: Text(
                                "ویرایش",
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
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              back: Container(
                width: width()/2,
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 70,
                          child: IconButton(
                            onPressed: () => editCardKey.currentState.toggleCard(),
                            icon: responseIcon,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _snackBar(String message, Color color){
    return SnackBar(
      duration: Duration(seconds: 2, milliseconds: 500),
      backgroundColor: color,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: "BNazanin",
        ),
      ),
    );

  }
}
