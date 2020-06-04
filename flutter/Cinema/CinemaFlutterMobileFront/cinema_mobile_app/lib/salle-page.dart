import 'package:cinema_mobile_app/GlobalVariables.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SallesPage extends StatefulWidget {
  dynamic salle;
  SallesPage(this.salle);
  @override
  _SallesPageState createState() => _SallesPageState();
}

class _SallesPageState extends State<SallesPage> {
  List<dynamic> listsalles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('salles ${(widget.salle)['name']}'),),
      body:  Center(
          child: this.listsalles == null
              ? CircularProgressIndicator()
              : ListView.builder(

            itemCount:
            (this.listsalles == null ? 0 : this.listsalles.length),
            itemBuilder: (context, index) {

              return Card(

                color: Colors.green,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.white,
                          child: Text(this.listsalles[index]['name'],style: TextStyle(color: Colors.green),),
                          onPressed: () {

                            loadProjections(this.listsalles[index]);
                          },
                        ),
                      ),
                    ),
                    if(this.listsalles[index]['projections']!=null)

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Image.network(GlobalData.host+"/imageFilm/${this.listsalles[index]['currentProjections']['film']['id']}",width: 200,),
                          Column(

                            children: <Widget>[

                              ...(this.listsalles[index]['projections'] as List<dynamic>).map((projection){
                                return RaisedButton(
                                     color: Colors.white,
                                    child: Text("${projection['seance']['heureDebut']} (${projection['film']['duree']}),Prix=${projection['prix']} "
                                      ,style: TextStyle(color: Colors.green),),

                                  onPressed: (){

                                    loadTickets(projection,this.listsalles[index]);
                                  },


                                );

                              })
                            ],

                          )

                        ],

                      ),
                    ),
                      if(this.listsalles[index]['currentProjection']!=null)
                    Row(
                      children: <Widget>[
                          ...this.listsalles[index]['currentProjection']['ListTickets'].map((ticket){
                            RaisedButton(
                              child: ,

                            )

                          })


                      ],
                    )
                     ],
                    )

              );

                    },
                  ),
                ),
              );


  }

  @override
  void initState() {
    super.initState();
    loadSalles();

  }

  void loadSalles() {
    String url = this.widget.salle['_links']['salles']['href'];
    http.get(url).then((resp) {
      setState(() {
        this.listsalles = jsonDecode(resp.body)['_embedded']['salles'];
      });
    }).catchError((err) {
      print(err);
    });
  }
  loadProjections(salle){
   // String url1 = GlobalData.host+"/salles/${salle['id']}/projections?projection=p1";
    String url2 = salle['_links']['projections']['href'].toString()
        .replaceAll("{?projection}", "?projection=p1");
   // print(url1);

    http.get(url2).then((resp) {
      setState(() {
        print(salle);
        salle['projections'] = jsonDecode(resp.body)['_embedded']['projections'];
        print(2222);
        salle['currentProjections']=jsonDecode(resp.body)['_embedded']['projections'][0];

      });
    }).catchError((err) {
      print(err);
    });


  }

  void loadTickets(projection,salle) {
    //  String url = "http://192.168.1.102:8080/projections/1/tickets?projection=ticketproj";

    String url = projection['_links']['tickets']['_href'].toString().replaceAll("{?projection}", "?projection=ticketproj");
    print('dddddddd');
    http.get(url).then((resp){
      setState(() {
        projection['listTickets']=jsonDecode(resp.body)['_embedded']['tickets'];
        salle['currentProjection']=projection;
        print(projection);
      });


    }).catchError((err){
      print(err);

    });
  }
}
