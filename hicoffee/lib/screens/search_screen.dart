import 'package:flutter/material.dart';
import 'package:hicoffee/blocs/requests_provider.dart';

import 'package:hicoffee/model/item.dart';

import 'package:hicoffee/widgets/wave.dart';
import 'package:hicoffee/widgets/cardLists.dart';
import 'package:provider/provider.dart';





class SearchScreen extends StatefulWidget {

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
    final RequestsProvider requestsProvider = Provider.of<RequestsProvider>(context);
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
            textDirection: TextDirection.rtl,
            controller: editingController,
            decoration: InputDecoration(
              alignLabelWithHint: true,
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
                  for (int i = 0; i < requestsProvider.items.length; i++) {
                    if (requestsProvider.items[i].name.toLowerCase().contains(
                        value.toLowerCase())) {
//                      print("IF ${widget.list[i].name}");
                      tempList.add(requestsProvider.items[i]);
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
