import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:hicoffee/model/log_model.dart';

import 'package:hicoffee/blocs/logs_provider.dart';


class CustomIcon {
  IconData icon;
  Color borderColor;
  Color backColor;
  CustomIcon(
      this.icon,
      this.borderColor,
      this.backColor,
      );
}


class LogScreen extends StatefulWidget {
  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {

  List<Log> _logs = [];
  Color addBorderColor    = Colors.lightGreen[700];
  Color addBackColor      = Colors.lightGreen[50];
  Color editBorderColor   = Colors.blue[700];
  Color editBackColor     = Colors.lightBlue[50];
  Color deleteBorderColor = Colors.red[700];
  Color deleteBackColor   = Colors.pink[50];
  Color sellBorderColor   = Colors.yellow[900];
  Color sellBackColor     = Colors.yellow[50];
  List<int> selectedIcon = [0, 1, 2, 3];


  List<Log> filterLogs(List<Log> logs){
    List<Log> temp_logs = [];
    for(int i=0 ; i<logs.length ; i++){
      if(logs[i].type == 'add')
        if(selectedIcon.indexOf(0) != -1)
          temp_logs.add(logs[i]);
      if(logs[i].type == 'edit')
        if(selectedIcon.indexOf(1) != -1)
          temp_logs.add(logs[i]);
      if(logs[i].type == 'delete')
        if(selectedIcon.indexOf(2) != -1)
          temp_logs.add(logs[i]);
      if(logs[i].type == 'sell')
        if(selectedIcon.indexOf(3) != -1)
          temp_logs.add(logs[i]);
    }
    return temp_logs;
  }


  @override
  Widget build(BuildContext context) {
    final LogsProvider logsProvider = Provider.of<LogsProvider>(context);
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _icons.asMap().entries.map((MapEntry map) => _buildIcon(map.key)).toList(),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context){
                _logs = filterLogs(logsProvider.logs);
                return ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (context, index){
                      return _showLog(_logs[index]);
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<CustomIcon> _icons = [
    CustomIcon(
      Icons.add,
      Colors.lightGreen[700],
      Colors.lightGreen[50]
    ),
    CustomIcon(
      Icons.edit,
      Colors.blue[700],
      Colors.lightBlue[50]
    ),
    CustomIcon(
      Icons.delete,
      Colors.red[700],
      Colors.pink[50]
    ),
    CustomIcon(
      FontAwesomeIcons.coins,
      Colors.yellow[900],
      Colors.yellow[50]
    ),
  ];

  Widget _buildIcon(int index){
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          if(selectedIcon.indexOf(index) == -1)
            selectedIcon.add(index);
          else
            selectedIcon.remove(index);
        });
      },
      child: Container(
        height: size.width/7,
        width: size.width/7,
        margin: EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          color: selectedIcon.indexOf(index) != -1 ? _icons[index].backColor  : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: selectedIcon.indexOf(index) != -1 ? _icons[index].borderColor : Colors.black12,
            width: 2.0,
          ),
        ),
        child: Icon(
          _icons[index].icon,
          size: 20.0,
          color: selectedIcon.indexOf(index) != -1 ? _icons[index].borderColor : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  Widget _showLog(Log log){
    Color borderColor;
    Color backColor;
    if(log.type == "add") {
      borderColor = addBorderColor;
      backColor = addBackColor;

    }else if(log.type == "edit"){
      borderColor = editBorderColor;
      backColor = editBackColor;

    }else if(log.type == "delete"){
      borderColor = deleteBorderColor;
      backColor = deleteBackColor;

    }else if(log.type == "sell"){
      borderColor = sellBorderColor;
      backColor = sellBackColor;
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(
                color: borderColor,
                width: 2.0,
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  log.text,
                  style: TextStyle(
                    fontFamily: "BNazanin",
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -4.8,
            left: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              color: backColor,
              child: Text(
                log.date,
                style: TextStyle(
                  fontFamily: "BNazanin",
                  fontWeight: FontWeight.bold,
                  color: borderColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
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
      title: Text(
        "Log",
        style: TextStyle(
          fontSize: 28.0,
          fontFamily: "Waltograph",
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

