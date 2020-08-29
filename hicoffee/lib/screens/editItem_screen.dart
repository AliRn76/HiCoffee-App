import 'dart:ui';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:clay_containers/clay_containers.dart';

import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/blocs/connection_provider.dart';

import 'package:hicoffee/model/item_model.dart';



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
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    Color acceptColor = Colors.greenAccent[200];
    Color errorColor = Colors.redAccent[400];
    int _value = widget.item.number;
    String countType = widget.item.countType;
    String responseMessage = "لطفا صبر کنید";
    Color responseColor = Theme.of(context).primaryColor;
    Icon responseIcon = Icon(Icons.done, color: Color(0xFF66c2ff),);
    double height() => MediaQuery.of(context).size.height;
    double width() => MediaQuery.of(context).size.width;


    void tryEditItem(requestsProvider, networkProvider, setter, logsProvider) async{
      int statusCode;
      String old_name = widget.item.name;
      String name = nameController.text;
      int number = _value;
      print(old_name);
      print(name);
      print(number);
      if (name == old_name && number == widget.item.number && countType == widget.item.countType){
        setter(() {
          responseMessage = "باموفقیت ویرایش شد";
          responseColor = acceptColor;
          responseIcon = Icon(Icons.done_all, color: responseColor);
        });
        return;
      }
      if(networkProvider.connection == false){
        setter(() {
          responseMessage = "ابتدا به اینترنت متصل شوید";
          responseColor = errorColor;
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
          responseColor = errorColor;
          responseIcon = Icon(Icons.close, color: responseColor);
        });
      }else{
        statusCode = await requestsProvider.reqEditItem(old_name, name, number, countType);
        print("Edit statusCode: $statusCode");
        setter(() {
          if(statusCode == 202){
            logsProvider.reqShowLogs();
            Navigator.pop(context, true);
            responseMessage = "باموفقیت ویرایش شد";
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 4, color: acceptColor),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            responseMessage,
                            style: TextStyle(
                              fontFamily: "BNazanin",
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
//            Navigator.pop(context, true);
          }else if(statusCode == 406){

            responseMessage = "نام محصول تکراری است";
            responseColor = errorColor;
            responseIcon = Icon(Icons.close, color: responseColor);
          }
          else{
            responseMessage = " خطا $statusCode";
            responseColor = errorColor;
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
                                  border: Border.all(color: Colors.blue[400], width: 1.3),
                                ),
                                onChanged: (newValue) =>
                                    setter(() => _value = newValue)
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height()/30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomRadioButton(
                          enableShape: true,
                          elevation: 2,
                          defaultSelected: countType,
                          enableButtonWrap: true,
                          width: 70,
                          autoWidth: false,
                          unSelectedColor: Theme.of(context).scaffoldBackgroundColor,
                          buttonLables: [
                            "کیلو",
                            "تعداد",
                          ],
                          buttonValues: [
                            "کیلو",
                            "تعداد",
                          ],
                          radioButtonValue: (value) {
                            countType = value;
                          },
                          selectedColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: height()/20),
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
                                tryEditItem(requestsProvider, networkProvider, setter, logsProvider);
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
                  children: <Widget>[
                      SizedBox(height: height()/10),
                    Text(
                      responseMessage,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "BNazanin",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: height()/10),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
