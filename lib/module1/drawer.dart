import 'package:flutter/material.dart';
import 'package:object_detection/constant.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //drawer
      child: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("Aqsa Ameen"),
              accountEmail: Text("aqsaameen07@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              decoration: BoxDecoration(
                color: kprimaryColor,
              )),
          Text(
            "About Us",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          Text(
              "\ \" Be an eye for everyone\" \n               \n At Envision, we belive there is a better way to make some one's daily activites easy. A more valueable way where some special people can maintain their privicy with minimal interfarence of other people."),
        ]),
      ),
    );
  }
}
