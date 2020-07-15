import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';

class CardLists extends StatelessWidget {
  List<String> list = [];

  CardLists({this.list});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context){
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index){
            return SimpleFoldingCell.create(
                frontWidget: _buildFrontWidget(list[index]),
                innerWidget: _buildInnerWidget(list[index]),
                cellSize: Size(MediaQuery.of(context).size.width, 80),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                animationDuration: Duration(milliseconds: 300),
                borderRadius: 20,
                onOpen: () => print('cell opened'),
                onClose: () => print('cell closed')
            );
          },
        );
      },
    );
  }
}



Widget _buildFrontWidget(String name) {
  return Builder(
    builder: (BuildContext context){
      return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).accentColor,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800
                ),
              ),
              FlatButton(
                onPressed: () {
                  final foldingCellState = context
                      .findAncestorStateOfType<SimpleFoldingCellState>();
                  foldingCellState?.toggleFold();
                },
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 30.0,
                  color: Theme.of(context).accentColor,
                ),
              )
            ],
          )
      );
    },
  );
}

Widget _buildInnerWidget(String name) {
  return Builder(
    builder: (BuildContext context){
      return Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            width: MediaQuery.of(context).size.width - 30,
            height: 85.0,
            child: Container(
              color: Colors.purpleAccent[100],
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            height: 85.0,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 30.0,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: FlatButton(
                  onPressed: () {
                    final foldingCellState = context
                        .findAncestorStateOfType<SimpleFoldingCellState>();
                    foldingCellState?.toggleFold();
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 30.0,
                    color: Theme.of(context).accentColor,
                  ),
                  //          splashColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
