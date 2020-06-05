import 'package:cinema_mobile_app/MenuItem.dart';
import 'package:cinema_mobile_app/ville-page.dart';
import 'package:flutter/material.dart';
import 'package:cinema_mobile_app/setting-page.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.green),
      ),
      home: MyApp(),
    ));
/*void main() {
  runApp(MyApp());
}*/

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  final menus = [
    {'title': 'Home', 'icon': Icon(Icons.home), 'page': VillePage()},
    {'title': 'Setting', 'icon': Icon(Icons.settings), 'page': SettingPage()},
    {'title': 'Contact', 'icon': Icon(Icons.contacts), 'page': SettingPage()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Ahmed Joti"),
      ),
      body:
      Center(




              child: Text(
                "Ahmed_Developpement(Mobile)",
                style: TextStyle(color: Colors.white,fontSize: 25,),

          ),



      ),

      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("./images/profile.png"),
                  radius: 70,
                ),
              ),
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.white, Colors.green])),
            ),
            ...this.menus.map((item) {
              return new Column(
                children: <Widget>[
                  Divider(color: Colors.green),
                  MenuItem(item['title'], item['icon'], (context) {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => item['page']));
                  })
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
