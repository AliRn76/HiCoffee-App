import 'package:flutter/services.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:drawerbehavior/drawerbehavior.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'restaurant',
        title: 'Home',
      ),
      new MenuItem(
        id: 'other1',
        title: 'Chart',
      ),
      new MenuItem(
        id: 'other2',
        title: 'Settings',
      ),
      new MenuItem(
        id: 'other3',
        title: 'Donate Developer',
      ),
    ],
  );

  bool clickedOnSearch = false;
  int selectedMenuItemId;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      drawers: [
        _drawer(),
      ],
      builder: (context, id) => Center(
          child: Scaffold(
            body: SafeArea(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  children: <Widget>[
                    _searchBar(),
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
            floatingActionButton: _floatingActionButton(),
          ),
      ),
    );
  }


  Widget _searchBar(){
    if (clickedOnSearch){
      return Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 6),
        child: TextField(
          onChanged: (value) {
            print(value);
          },
          controller: editingController,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      );
    }else{
      return Row(
        children: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.dehaze,
            ),
          ),
          IconButton(
            onPressed: (){
              setState(() {
                clickedOnSearch = true;
              });
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      );
    }

  }

  Widget _drawer(){
    return SideDrawer(
        degree: 45,
        color: Theme.of(context).primaryColor,
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (itemId) {
          setState(() {
            selectedMenuItemId = itemId;
          });
        },
        menu: menu,
        itemBuilder:
            (BuildContext context, MenuItem itemMenu, bool isSelected) {
          return Container(
            color: isSelected
                ? Theme.of(context).accentColor.withOpacity(0.7)
                : Colors.transparent,
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Text(
              itemMenu.title,
              style: Theme.of(context).textTheme.subhead.copyWith(
//                      color: isSelected ? Colors.black87 : Colors.black54),
                  color: Colors.black87),
            ),
          );
        }
    );
  }

  Widget _cardLists(){
    return ListView.builder(
      itemCount: 200,
      itemBuilder: (context, index){
        return SimpleFoldingCell.create(
            frontWidget: _buildFrontWidget(),
            innerWidget: _buildInnerWidget(),
            cellSize: Size(MediaQuery.of(context).size.width, 85),
            padding: EdgeInsets.all(15),
            animationDuration: Duration(milliseconds: 300),
            borderRadius: 20,
            onOpen: () => print('cell opened'),
            onClose: () => print('cell closed')
        );
      },
    );
  }

  Widget _buildFrontWidget() {
    return Builder(
      builder: (BuildContext context){
        return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: Theme.of(context).accentColor,
                width: 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("CARD",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
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

  Widget _buildInnerWidget() {
    return Builder(
      builder: (context){
        return Stack(
          children: <Widget>[
            Positioned(
              top: 0.0,
              width: MediaQuery.of(context).size.width - 30,
              height: 85.0,
              child: Container(
                color: Colors.purpleAccent[100],
                alignment: Alignment.center,
                child: Text("Description",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)
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
      }
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

  Widget _floatingActionButton(){
    return Align(
      alignment: Alignment(0.9, 0.95),
      child: FloatingActionButton(
        splashColor: Colors.blue,
        onPressed: (){},
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
