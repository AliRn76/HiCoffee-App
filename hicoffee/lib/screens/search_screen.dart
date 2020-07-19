import 'package:flutter/material.dart';

import 'package:hicoffee/model/item.dart';

import 'package:hicoffee/widgets/wave.dart';
import 'package:hicoffee/widgets/cardLists.dart';





class SearchScreen extends StatefulWidget {
  List<Item> list;
  SearchScreen({this.list});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}



class _SearchScreenState extends State<SearchScreen> {
  List<Item> tempList = [];
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(0.0),
          child: TextField(
            autofocus: false,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            controller: editingController,
            decoration: InputDecoration(
              labelText: "Search",
//              hintText: "Search",
              prefixIcon: Hero(
                tag: "search",
                child: Icon(Icons.search)
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  tempList.clear();
                  print(value);
                  for (int i = 0; i < widget.list.length; i++) {
                    if (widget.list[i].name.toLowerCase().contains(
                        value.toLowerCase())) {
//                      print("IF ${widget.list[i].name}");
                      tempList.add(widget.list[i]);
                    }
                  }
//                  print(tempList);
                });
              }
            },
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
