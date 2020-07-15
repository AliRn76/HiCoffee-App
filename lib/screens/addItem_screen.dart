import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hicoffee/screens/search_screen.dart';
import 'package:hicoffee/widgets/wave.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';

class AddItemScreen extends StatefulWidget {
  List<String> list = [];
  AddItemScreen({this.list});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController description = TextEditingController();
  Icon customIcon = Icon(Icons.search);
  double _value = 0;
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor ,
        child: Expanded(
            child: Stack(
              children: <Widget>[
                Center(
                  child: FlipCard(
                    key: cardKey,
                    flipOnTouch: false,
                    direction: FlipDirection.VERTICAL,
                    front: _fromView(),
                    back: _backView(),
                  ),
                ),
                Wave(),
              ],
            )
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen(list: widget.list,)),
              );
            },
            icon: customIcon,
          ),
        ]
    );
  }

  Widget _fromView(){
    return Container(
      height: MediaQuery.of(context).size.height - 200,

      width: 250.0,
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
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "BNazanin",
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: "Name",
                contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FluidSlider(
              labelsTextStyle: TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
              value: _value,
              valueTextStyle: TextStyle(
                fontSize: 17.0,
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
          RaisedButton(
            color: Colors.lightGreenAccent[100],
            onPressed: () => cardKey.currentState.toggleCard(),
            child: Text('Add Item'),
          ),
        ],
      ),
    );
  }

  Widget _backView(){
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 200,
          color: Colors.white12,
          width: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () => cardKey.currentState.toggleCard(),
                icon: Icon(
                    Icons.adb
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

