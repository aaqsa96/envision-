import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:object_detection/main.dart';
import 'package:object_detection/module1/drawer.dart';
import 'package:object_detection/module1/realtime/live_camera.dart';
import 'package:object_detection/module3/battery.dart';
import 'package:flutter/cupertino.dart';
import 'package:object_detection/constant.dart';
//import 'package:object_detection/splashScreen.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:object_detection/module4/location.dart';
import 'package:object_detection/module2/textReader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _swipeDirection = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Envision",
          style: TextStyle(fontSize: 28, fontFamily: "LobsterTwo"),
        ),
        toolbarHeight: 70,
        centerTitle: true,
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          child: Card(
            color: kCardsColor,
            child: Column(children: [
              SwipeDetector(
                  child: Card(
                    color: OneCardColor,
                    margin: EdgeInsets.fromLTRB(20.0, 16.0, 22.0, 5.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    // clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'title',
                          child: Container(color: OneCardColor),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'one',
                            child: CircleAvatar(
                              //child: Icon(Icons.search_rounded),
                              backgroundColor: OneCardColor,
                              backgroundImage: AssetImage(
                                'assets/images/search-1.png',
                              ),
                              radius: 55,
                            ),
                          ),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'text',
                            child: Text(
                              'Object Detection',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "LobsterTwo",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text('swipe up'),
                      ],
                    ),
                  ),
                  onSwipeUp: () {
                    setState(
                      () {
                        _swipeDirection = "Swipe Up";
                      },
                    );
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => homeDetailScreen()));
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionDuration: Duration(seconds: 1),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            //return homeDetailScreen();
                            return LiveFeed(cameras);
                          },
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: animation, curve: Curves.elasticOut),
                              // animation,
                              child: child,
                            );
                          }),
                    );
                  }),
              ///////2////
              SwipeDetector(
                  child: Card(
                    color: TwoCardColor,
                    margin: EdgeInsets.fromLTRB(20.0, 14.0, 22.0, 5.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    // clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'title1',
                          child: Container(color: OneCardColor),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'two',
                            child: Image.asset('assets/images/book.png',
                                fit: BoxFit.fitWidth, height: 100.0),
                          ),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'text1',
                            child: Text(
                              'Text Recogination',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "LobsterTwo",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text('swip left'),
                      ],
                    ),
                  ),
                  onSwipeLeft: () {
                    setState(
                      () {
                        _swipeDirection = "Swipe Left";
                      },
                    );
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => homeDetailScreen()));
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionDuration: Duration(seconds: 2),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return TextReader();
                          },
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          }),
                    );
                  }),
              /////////3333///////////////////////////////
              SwipeDetector(
                  child: Card(
                    color: ThreeCardColor,

                    margin: EdgeInsets.fromLTRB(20.0, 14.0, 22.0, 5.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    // clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'title3',
                          child: Container(color: ThreeCardColor),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'three',
                            child: CircleAvatar(
                              backgroundColor: ThreeCardColor,
                              backgroundImage: AssetImage(
                                'assets/images/charge-battery.png',
                              ),
                              radius: 50,
                            ),
                          ),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'text2',
                            child: Text(
                              'Battery checker',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                //fontFamily: "LobsterTwo",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text('swipe right'),
                      ],
                    ),
                  ),
                  onSwipeRight: () {
                    setState(
                      () {
                        _swipeDirection = "Swipe Right";
                      },
                    );
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => homeDetailScreen()));
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionDuration: Duration(seconds: 2),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return BatteryPage();
                          },
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          }),
                    );
                  }),

              ///
              /////4////////////////////
              SwipeDetector(
                  child: Card(
                    color: FourCardColor,
                    margin: EdgeInsets.fromLTRB(20.0, 14.0, 22.0, 5.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    // clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'title4',
                          child: Container(color: FourCardColor),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'four',
                            child: Image.asset('assets/images/location.png',
                                fit: BoxFit.fitWidth, height: 100.0),
                          ),
                        ),
                        Positioned(
                          child: Hero(
                            tag: 'text3',
                            child: Text(
                              'Location Finder',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                // fontFamily: "LobsterTwo",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text('swipe down'),
                      ],
                    ),
                  ),
                  onSwipeDown: () {
                    setState(
                      () {
                        _swipeDirection = "Swipe Down";
                      },
                    );
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => homeDetailScreen()));
                    Navigator.of(context).push(
                      PageRouteBuilder(
                          fullscreenDialog: true,
                          transitionDuration: Duration(seconds: 2),
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return MyLocation();
                          },
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          }),
                    );
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
