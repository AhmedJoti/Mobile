import 'package:flutter/material.dart';
import './weather-details.dart';


class Weather  extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  String city="";
  TextEditingController cityEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,title: Text(city),),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(hintText: 'tapez une ville'),
                  style: TextStyle(
                      fontSize: 22),
                controller: cityEditingController,
                onChanged: (value){
                   setState(() {
                     this.city=value;              });
                },
                onSubmitted:(value){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>WeatherDetails(city)));
                  cityEditingController.text="";
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>WeatherDetails(city)));
                  cityEditingController.text="";
                },
                color : Colors.deepOrangeAccent,
                textColor: Colors.white,
                child: Text('Get Weather...',style: TextStyle(fontSize: 22,color:Colors.white),),

              ),
            ),
          )

        ],


      ),


    );
  }
}
