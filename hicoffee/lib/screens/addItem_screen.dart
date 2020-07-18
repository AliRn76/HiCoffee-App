import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/screens/search_screen.dart';
import 'package:hicoffee/widgets/wave.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:hicoffee/model/item.dart';

class AddItemScreen extends StatefulWidget {
  List<Item> list = [];
  AddItemScreen({this.list});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  GlobalKey<FlipCardState> addCardKey = GlobalKey<FlipCardState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController description = TextEditingController();
  Icon customIcon = Icon(Icons.search);
  Color baseColor = Color(0xFFF2F2F2);
  double _value = 0;
  Widget customTitle = Text(
    "Hi Coffee",
    style: TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    ),
  );

  double height(){
    return MediaQuery.of(context).size.height;
  }

  double width(){
    return MediaQuery.of(context).size.width;
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
        title: customTitle,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 600),
                    pageBuilder: (_, __, ___) => SearchScreen(list: widget.list)
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
                  hintText: "Name",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                  child: IconButton(
                    onPressed: () => addCardKey.currentState.toggleCard(),
                    icon: Icon(
                      Icons.add_shopping_cart,
                    ),
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
            color: Theme.of(context).primaryColor,
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
              "Successfully Added",
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
                    icon: Icon(
                      Icons.done
                    ),
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
}
