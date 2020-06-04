import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cinemas-page.dart';
import './GlobalVariables.dart';

class VillePage extends StatefulWidget {
  @override
  _VillePageState createState() => _VillePageState();
}

class _VillePageState extends State<VillePage> {
  List<dynamic> listVilles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Villes'),
      ),
      body: Center(
          child: this.listVilles == null
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount:
                      (this.listVilles == null ? 0 : this.listVilles.length),
                  itemBuilder: (context, index) {

                    return Card(
                      color: Colors.green,
                      child: Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text(this.listVilles[index]['name'],style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>CinemasPage(listVilles[index])));

                          },
                        ),
                      ),
                    );
                  },
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    loadVilles();
  }

  void loadVilles() {

//    String url = "http://192.168.1.102:8080/villes";
    String url = GlobalData.host+"/villes";

    http.get(url).then((resp) {
      setState(() {
        this.listVilles = jsonDecode(resp.body)['_embedded']['villes'];

      });
    }).catchError((err) {
      print(err);
    });

  }
}
