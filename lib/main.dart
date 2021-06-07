//import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/constant.dart';
import 'package:object_detection/module1/homePage/home.dart';
import 'package:object_detection/module1/realtime/live_camera.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:object_detection/module2/textReader.dart';
import 'package:object_detection/module3/battery.dart';
import 'package:object_detection/module4/location.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // running the appz

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: MyApp(), 2: MyApp()};
  runApp(
    MaterialApp(
      home: CustomSplash(
        imagePath: 'assets/images/logo2.jpg',
        // backGroundColor: kprimaryColor,
        backGroundColor: Color(0xfff0a1433),
        // #050b1c, 0a132e,0a1433
        animationEffect: 'zoom-in',
        logoSize: 900,
        home: MyApp(),
        customFunction: duringSplash,
        duration: 3000,
        type: CustomSplashType.StaticDuration,
        outputAndHome: op,
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kprimaryColor,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    AlanVoice.addButton(
        "a67f457b762c4ffcd92f430e396b45952e956eca572e1d8b807a3e2338fdd0dc/stage");
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
    // ignore: deprecated_member_use
    AlanVoice.addConnectionCallback((state) => _handleConnectionState(state));

    super.initState();
  }

  void _handleConnectionState(String state) {
    if (state == "CONNECTED") {
      print("****************  connected  ****************");
    }
  }

  void _handleCommand(Map command) {
    print(
        "************************************************ New command: $command");

    switch (command["title"]) {
      case "OBJECT_DETECTION":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LiveFeed(cameras)));
        break;
      case "text recognition":
        print(
            "************************************************ SETTINGS CASE EXECUTED **********************");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TextReader()));

        //openSetting();
        break;
      case "battery checker":
        print(
            "************************************************ SETTINGS CASE EXECUTED **********************");

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BatteryPage()));

        //openSetting();
        break;
      case "location finder":
        print(
            "*********************** PROFILE CASE EXECUTED ------ YOUR STUFF HERE**********************");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLocation()));
        //openSetting();
        break;

      default:
        print("********************** Unknown command: $command");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      //body: splash(),
    );
  }
}
