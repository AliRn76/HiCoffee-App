import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:number_selection/number_selection.dart';
import 'package:hicoffee/model/item.dart';

class CardLists extends StatelessWidget {
  List<Item> list = [];
  CardLists({this.list});

  @override
  Widget build(BuildContext context) {
    double width() => MediaQuery.of(context).size.width;
    double height() => MediaQuery.of(context).size.height;

    return Builder(
      builder: (BuildContext context){
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            if (list[index].name == null)
              return Container(height: 100);
            else
              return Center(
                child: SimpleFoldingCell.create(
                    frontWidget: _buildFrontWidget(list[index]),
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

  Widget _buildFrontWidget(Item item) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
//                          color: Colors.green,
                          margin: EdgeInsets.only(right: 20.0),
                          child: Text(
                            item.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "تعداد:  ",
                                style: TextStyle(
                                  fontSize: 19.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item.number.toString(),
                                style: TextStyle(
                                  fontSize: 19.0,
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
//                height: 40.0,
//                    color: Colors.red,
                    child: IconButton(
                      onPressed: () {
                        final foldingCellState = context
                            .findAncestorStateOfType<SimpleFoldingCellState>();
                        foldingCellState?.toggleFold();
                      },
                      iconSize: 35.0,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                )
              ],
            )
        );
      },
    );
  }

  Widget _buildInnerWidget(BuildContext context, Item item) {
    double width() => MediaQuery.of(context).size.width;
    double height() => MediaQuery.of(context).size.height;

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
                        width: width()/2.8,
                        child: NumberSelection(
                          initialValue: 0,
                          maxValue: item.number,
                          minValue: 0,
                          direction: Axis.horizontal,
                          withSpring: false,
                          onChanged: (int value) => print('new value $value'),
                        ),
                      ),
                      ClayContainer(
                        depth: 40,
                        emboss: false,
                        curveType: CurveType.convex,
//                      curveType: CurveType.concave,
                        borderRadius: 12.0,
                        color: Colors.greenAccent[200],
                        width: width()/4.5,
                        height: height()/15,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                          onPressed: (){print("SOLD");},
                          child: ClayText(
                            "Sold",
                            emboss: true,
                            depth: 20,
                            color: Colors.black45,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
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
                color: Colors.white,
                width: width() - width()/6,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: 27.0,
                        color: Colors.redAccent[400],
                        onPressed: (){},
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
                        //          splashColor: Colors.white.withOpacity(0.5),
                      ),
                      IconButton(
                        color: Colors.grey[600],
                        iconSize: 27.0,
                        icon: Icon(Icons.edit),
                        onPressed: (){},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


}



