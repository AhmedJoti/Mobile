import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SallesPage extends StatefulWidget {
  dynamic sallee;
  SallesPage(this.sallee);
  @override
  _SallesPageState createState() => _SallesPageState();
}

class _SallesPageState extends State<SallesPage> {
  List<dynamic> listsalles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('salles ${(widget.sallee)['name']}'),),
      body:  Center(
          child: this.listsalles == null
              ? CircularProgressIndicator()
              : ListView.builder(
            itemCount:
            (this.listsalles == null ? 0 : this.listsalles.length),
            itemBuilder: (context, index) {

              return Card(
                color: Colors.green,
                child: Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.white,
                    child: Text(this.listsalles[index]['name'],style: TextStyle(color: Colors.green),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>SallesPage(listsalles[index])
                      )
                      );

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
    loadSalles();
  }

  void loadSalles() {
    String url = this.widget.sallee['_links']['salles']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listsalles = jsonDecode(resp.body)['_embedded']['salles'];
      });
    }).catchError((err) {
      print(err);
    });
  }
}
