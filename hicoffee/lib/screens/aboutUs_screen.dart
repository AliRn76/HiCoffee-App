import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>  with SingleTickerProviderStateMixin{
  double width() => MediaQuery.of(context).size.width;
  double height() => MediaQuery.of(context).size.height;


  Color baseColor = Color(0xFFf2f2f2);
  double firstDepth = 50;
  double secondDepth = 50;
  double thirdDepth = 50;
  double fourthDepth = 50;
  AnimationController _animationController;


  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 6),// the SingleTickerProviderStateMixin
      vsync: this,
    )..addListener(() {
      setState(() {});
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double stagger(value, progress, delay) {
      progress = progress - (1 - delay);
      if (progress < 0) progress = 0;
      return value * (progress / delay);
    }
    double calculatedFirstDepth =
    stagger(firstDepth, _animationController.value, 0.25);
    double calculatedSecondDepth =
    stagger(secondDepth, _animationController.value, 0.5);
    double calculatedThirdDepth =
    stagger(thirdDepth, _animationController.value, 0.75);
    double calculatedFourthDepth =
    stagger(fourthDepth, _animationController.value, 1);

    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: height()/6,
//                      color: Colors.red,
              ),
              SizedBox(width: width()/12),
              Container(
                width: width() - width()/12 - 8,
                height: height()/6,
                child: Align(
                  alignment: Alignment(-0.4,0),
                  child: Text(
                    "There is no us \n             It's me  :)",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: "Milton",
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: height()/11,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: width()/8),
              Align(
                alignment: Alignment(-1, 0),
                child: Container(
                  width: width() - width()/8 - 8,
                  height: height()/11,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hi !   I'm Ali",
                        style: TextStyle(
                          fontFamily: "Milton",
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: height()/4,
                color: Colors.greenAccent[200],
              ),
              SizedBox(width: width()/8),
              Container(
                width: width() - width()/8 - 8,
                height: height()/4,
                child: Align(
                  alignment: Alignment(-1.0, 0.0),
                  child: Text(
                    "I work with:\n\n"
                        "    1.   Flutter in Client-Side\n"
                        "    2.   Django in Server-Side",
                    style: TextStyle(
                      fontFamily: "Milton",
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: height()/6,
                color: Colors.blue,
              ),
              SizedBox(width: width()/8),
              Container(
                width: width() - width()/8 - 8,
                height: height()/6,
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                    SizedBox(width: width()/16),
                      Text(
                        "Donate Me  ",
                        style: TextStyle(
                          fontFamily: "Milton",
                          fontSize: 20.0,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 22.0,
                      ),
                      SizedBox(width: 10.0),
                      Center(
                        child: ClayContainer(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: 85,
                          width: 85,
                          borderRadius: 200,
                          curveType: CurveType.concave,
                          spread: 30,
                          depth: calculatedFirstDepth.toInt(),
                          child: Center(
                            child: ClayContainer(
                              height: 75,
                              width: 75,
                              borderRadius: 200,
                              depth: calculatedSecondDepth.toInt(),
                              curveType: CurveType.convex,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Center(
                                child: ClayContainer(
                                    height: 60,
                                    width: 60,
                                    borderRadius: 200,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    depth: calculatedThirdDepth.toInt(),
                                    curveType: CurveType.concave,
                                    child: Center(
                                        child: ClayContainer(
                                          height: 50,
                                          width: 50,
                                          borderRadius: 200,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          depth: calculatedFourthDepth.toInt(),
                                          curveType: CurveType.convex,
                                          child: IconButton(
                                            icon: FaIcon(FontAwesomeIcons.handHoldingUsd),
                                            onPressed: () => launch('https://idpay.ir/alirn'),
                                            color: Colors.blue[600],
                                            splashColor: Colors.blue,
                                            hoverColor: Colors.blue,
                                          ),
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: height()/8,
              ),
              SizedBox(width: width()/8),
              Container(
                width: width() - width()/8 - 8,
                height: height()/8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: width()/10),
                        FaIcon(
                          FontAwesomeIcons.github,
                          size: 25.0,
                        ),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '     Github.com/AliRn76',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () { launch('https://github.com/AliRn76');
                                    },
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: width()/10),
                        FaIcon(
                          FontAwesomeIcons.userAlt,
                          size: 25.0,
                        ),
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '     Contact Me',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () { launch('http://Alirn.ir');
                                    },
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
          "About Us",
          style: TextStyle(
              fontSize: 28.0,
              fontFamily: "Waltograph",
              letterSpacing: 2.5,
          ),
        ),
    );
  }
}
