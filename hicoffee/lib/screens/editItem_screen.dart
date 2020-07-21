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
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    TextEditingController nameController = TextEditingController(text: widget.item.name);
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    Color acceptColor = Colors.greenAccent[200];
    Color deleteColor = Colors.redAccent[400];
    Color editColor = Colors.grey[600];
    int _value = 0;
    String responseMessage = "لطفا صبر کنید";
    Color responseColor = Theme.of(context).primaryColor;
    Icon responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
    double height() => MediaQuery.of(context).size.height;
    double width() => MediaQuery.of(context).size.width;


    void tryEditItem(RequestsProvider requestsProvider, NetworkProvider networkProvider){
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

    }


    return IconButton(
      color: editColor,
      iconSize: 27.0,
      icon: Icon(Icons.edit),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(width: 2, color: responseColor),
                  ),
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState){
                      return SingleChildScrollView(
                        child: Center(
                          child: FlipCard(
//                        flipOnTouch: false,
                            key: cardKey,
                            direction: FlipDirection.HORIZONTAL,
                            front:Container(
//                          height: height()/3,
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
                                                  setState(() => _value = newValue)
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
                                              tryEditItem(requestsProvider, networkProvider);
                                              return cardKey.currentState.toggleCard();
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
                            ) ,
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
                                          onPressed: () => cardKey.currentState.toggleCard(),
                                          icon: responseIcon,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
        );
      },
    );
  }
}
