import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class SearchScreen extends StatefulWidget {
  List<String> list;
  SearchScreen({this.list});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> tempList = [];
  Icon customIcon = Icon(Icons.search);
  TextEditingController editingController = TextEditingController();

  Widget customTitle = Text(
    "Hi Coffee",
    style: TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
//                _searchBar(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _cardLists(),
                    _wave(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(0.0),
          child: TextField(
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            onChanged: (value) {
              if (!(value.isEmpty)) {
                setState(() {
                  tempList.clear();
                  print(value);
                  for (int i = 0; i < widget.list.length; i++) {
                    if (widget.list[i].toLowerCase().contains(
                        value.toLowerCase())) {
                      tempList.add(widget.list[i]);
                    }
                  }
                  print(tempList);
                });
              }
            },
            controller: editingController,
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              editingController.clear();
            },
            icon: Icon(Icons.cancel),
          )
        ]
    );
  }

  Widget _cardLists(){
    return Builder(
      builder: (BuildContext context){
        return ListView.builder(
          itemCount: tempList.length,
          itemBuilder: (context, index){
            return SimpleFoldingCell.create(
                frontWidget: _buildFrontWidget(tempList[index]),
                innerWidget: _buildInnerWidget(tempList[index]),
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

  Widget _wave(){
    return Positioned(
      bottom: 0.0,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
            [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
            [Color(0xFFfc00ff), Color(0xFF00dbde)],
            [Color(0xFF396afc), Color(0xFF2948ff)],
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          blur: MaskFilter.blur(BlurStyle.inner, 5),
          gradientBegin: Alignment.centerLeft,
          gradientEnd: Alignment.centerRight,
        ),
        waveAmplitude: 1,
        size: Size(
          MediaQuery.of(context).size.width,
          100.0,
        ),
      ),
    );
  }


}
