import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

import 'package:hicoffee/widgets/wave.dart';
import 'package:hicoffee/widgets/cardLists.dart';


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  CardLists(list: tempList),
                  Wave(),
                ],
              ),
            ),
          ],
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
            autofocus: true,
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
//              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              editingController.clear();
            },
            icon: Icon(Icons.cancel),
          )
        ]
    );
  }
}
