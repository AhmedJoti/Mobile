import 'package:flutter/material.dart';
import './quiz.dart';
import './camera.dart';
import './gallery.dart';
import './weather.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration:BoxDecoration(
                gradient: LinearGradient(colors: [Colors.green,Colors.white ])

            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/Birman.jpeg') ,
                radius: 60,
              ),
            ),

          ),
          ListTile(
            title:Text('Quiz',style: TextStyle(fontSize: 20),),
            onTap: (){

              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Quiz()));

            },
          ),
          Divider(),
          ListTile(
            title:Text('Weather',style: TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Weather()));

            },
          ),
          Divider(),
          ListTile(
            title:Text('Gallery',style: TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>Gallery()));

            },
          ),
          Divider(),
          ListTile(
            title:Text('Camera Page',style: TextStyle(fontSize: 20)),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder:(context)=>CameraPage()));

            },
          )

        ],

      ),
    );




  }
}
