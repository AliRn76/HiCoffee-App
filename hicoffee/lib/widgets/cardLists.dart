import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flip_card/flip_card.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:number_selection/number_selection.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hicoffee/blocs/logs_provider.dart';
import 'package:hicoffee/blocs/requests_provider.dart';
import 'package:hicoffee/blocs/connection_provider.dart';

import 'package:hicoffee/model/item_model.dart';

import 'package:hicoffee/screens/editItem_screen.dart';



class CardLists extends StatelessWidget {
  List<Item> list = [];
  CardLists({this.list});

  Color acceptColor = Colors.greenAccent[200];
  Color deleteColor = Colors.redAccent[400];
  Color editColor = Colors.grey[600];
  Color errorColor = Colors.redAccent[100];


  void deleteItem(context, item, requestsProvider, logsProvider, networkProvider) async{
    if(networkProvider.connection == false){
      Scaffold.of(context).showSnackBar(
          _snackBar("ابتدا به اینترنت متصل شوید", errorColor)
      );
    }else{
      int statusCode = await requestsProvider.reqDeleteItem(item);
      if(statusCode == 200){
        logsProvider.reqShowLogs();
        Scaffold.of(context).showSnackBar(
            _snackBar("با موفقیت حذف شد", deleteColor)
        );
        list.remove(item);
        requestsProvider.items.remove(item);
        final foldingCellState = context
            .findAncestorStateOfType<SimpleFoldingCellState>();
        foldingCellState?.toggleFold();
      }else{
        Scaffold.of(context).showSnackBar(
            _snackBar("حذف ناموفق بود - خطا $statusCode", errorColor)
        );
      }
    }
  }

  void sellItem(context, item, sellValue, requestsProvider, logsProvider, networkProvider) async{
    if(sellValue == 0)
      return;
    if(sellValue == null)
      return;
    if(networkProvider.connection == false){
      Scaffold.of(context).showSnackBar(
          _snackBar("ابتدا به اینترنت متصل شوید", errorColor)
      );
    }else{
      int statusCode = await requestsProvider.reqSellItem(item, sellValue);
      if(statusCode == 200){
        logsProvider.reqShowLogs();
        Scaffold.of(context).showSnackBar(
            _snackBar("با موفقیت فروخته شد", acceptColor)
        );
        final foldingCellState = context
            .findAncestorStateOfType<SimpleFoldingCellState>();
        foldingCellState?.toggleFold();
      }else{
        Scaffold.of(context).showSnackBar(
            _snackBar("فروش ناموفق بود - خطا $statusCode", errorColor)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width() => MediaQuery.of(context).size.width;
    double height() => MediaQuery.of(context).size.height;
    return Builder(
      builder: (BuildContext context){
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            if(index+1 == list.length)
              return Column(
                children: <Widget>[
                  SimpleFoldingCell.create(
                    frontWidget: _buildFrontWidget(context, list[index]),
                    innerWidget: _buildInnerWidget(context, list[index]),
                    cellSize: Size(width()/1.2, height()/7),
                    padding: EdgeInsets.symmetric(
                      vertical: height()/35,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: 20,
                    onOpen: () => print('cell opened'),
                    onClose: () => print('cell closed')
                  ),
                  SizedBox(height: 100.0),
                ],
              );
            else
              return Center(
                child: SimpleFoldingCell.create(
                  frontWidget: _buildFrontWidget(context, list[index]),
                  innerWidget: _buildInnerWidget(context, list[index]),
                  cellSize: Size(width()/1.2, height()/7),
                  padding: EdgeInsets.symmetric(
                    vertical: height()/35,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  borderRadius: 20,
                  onOpen: () => print('cell opened'),
                  onClose: () => print('cell closed')
                ),
              );
          },
        );
      },
    );
  }

  Widget _buildFrontWidget(BuildContext context, Item item) {
    double width() => MediaQuery.of(context).size.width;
    double height() => MediaQuery.of(context).size.height;
    return Builder(
      builder: (BuildContext context){
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).accentColor,
                width: 1.5,
              ),
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: height()/60, right: width()/25),
                  width: width()/1.35,
                  child: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'BTitr_Bold',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width()/20, top: height()/15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "تعداد:  ",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'BNazanin',
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        item.number.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'BTitr_Bold',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height()/13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          final foldingCellState = context
                              .findAncestorStateOfType<SimpleFoldingCellState>();
                          foldingCellState?.toggleFold();
                        },
                        iconSize: 35.0,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.lightBlue[700],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInnerWidget(BuildContext context, Item item) {
    int value;
    double width() => MediaQuery.of(context).size.width;
    double height() => MediaQuery.of(context).size.height;
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    return Builder(
      builder: (BuildContext context){
        return Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              width: width() - width()/6,
              height: height()/7,
              child: Container(
                color: Colors.greenAccent[200],
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: width()/3.3,
                        child: NumberSelection(
                          initialValue: 0,
                          maxValue: item.number,
                          minValue: 0,
                          direction: Axis.horizontal,
                          withSpring: false,
                          onChanged: (_value) {
                            value = _value;
                          },
                        ),
                      ),
                      ClayContainer(
                        depth: 40,
                        emboss: false,
                        curveType: CurveType.convex,
                        borderRadius: 12.0,
                        color: acceptColor,
                        width: width()/4.5,
                        height: height()/15,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                          onPressed: () => sellItem(context, item, value, requestsProvider, logsProvider, networkProvider),
                          child: FaIcon(
                            FontAwesomeIcons.coins,
                            color:  Colors.amber[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              height: height()/7,
              child: Container(
                color: Color(0xffd1fae6),
                width: width() - width()/6,
                child: _flipCard(context, item),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _flipCard(BuildContext context, Item item){
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    final NetworkProvider networkProvider = Provider.of<NetworkProvider>(context);
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      flipOnTouch: false,
      key: cardKey,
      front: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 27.0,
            color: deleteColor,
            onPressed: () => cardKey.currentState.toggleCard(),
          ),
          FlatButton(
            onPressed: () {
              final foldingCellState = context
                  .findAncestorStateOfType<SimpleFoldingCellState>();
              foldingCellState?.toggleFold();
            },
            child: Icon(
              Icons.keyboard_arrow_up,
              size: 40.0,
              color: Colors.blueAccent[200],
            ),
          ),
          IconButton(
            color: editColor,
            iconSize: 27.0,
            icon: Icon(Icons.edit),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                      ),
                      content: EditItemScreen(item: item),
                    ),
                  );
                }
              );
            },
          ),
        ],
      ),
      back: Container(
        color: Colors.red[100],
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "آیا از حذف اطمینان دارید؟",
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: "BNazanin",
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                color: deleteColor,
                iconSize: 26.0,
                onPressed: () => cardKey.currentState.toggleCard(),
              ),
              IconButton(
                icon: Icon(Icons.check),
                color: Colors.green,
                iconSize: 26.0,
                onPressed: () {
                  deleteItem(context, item, requestsProvider, logsProvider, networkProvider);
                  return cardKey.currentState.toggleCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _snackBar(String message, Color color){
    Color fontColor;
    if(color == acceptColor)
      fontColor = Colors.black;
    return SnackBar(
      duration: Duration(seconds: 1, milliseconds: 500),
      backgroundColor: color,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: "BNazanin",
        ),
      ),
    );
  }
}





