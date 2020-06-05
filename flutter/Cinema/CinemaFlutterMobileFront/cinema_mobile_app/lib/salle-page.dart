import 'package:cinema_mobile_app/GlobalVariables.dart';
import 'package:flutter/cupertino.dart';
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

                          Image.network(GlobalData.host+"/imageFilm/${this.listsalles[index]['currentProjection']['film']['id']}",width: 200,),
                          Column(

                            children: <Widget>[

                              ...(this.listsalles[index]['projections'] as List<dynamic>).map((projection){
                                return RaisedButton(
                                     color: ((this.listsalles[index]['currentProjection']['id']==projection['id'])?Colors.black:Colors.white70),

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

                      if(this.listsalles[index]['currentProjection']!=null && this.listsalles[index]['currentProjection']['listTickets']!=null
                          && this.listsalles[index]['currentProjection']['listTickets'].length>0)
                        Column(
                          children: <Widget>[
                            Row(

                              children: <Widget>[
                                Text("nombre de place dispo: ${this.listsalles[index]['currentProjection']['nbrPlaceDispo']} ",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                              ],
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
                                child: TextField(
                                  decoration: InputDecoration(hintText: 'Your name'),
                                  style: TextStyle(color: Colors.white),


                                ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(6, 2, 6, 3),

                              child: TextField(
                                decoration: InputDecoration(hintText: 'Code Paiement'),
                                style: TextStyle(color: Colors.white),

                              ),
                            ),

                            Container(
                              padding: EdgeInsets.fromLTRB(6, 2, 6, 3),

                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(hintText: 'nombre tickets'),

                              ),
                            ),
                               
                            
                            Container(
                              width: double.infinity,
                                child: RaisedButton(

                                    child: Text("Reserver les places",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    onPressed: null)),

                            Wrap(
                              children: <Widget>[
                                ...this.listsalles[index]['currentProjection']['listTickets'].map((ticket){
                                  if(ticket['reserve']==false)


                                    return Container(

                                      width: 50,
                                      padding: EdgeInsets.all(2),

                                      child: RaisedButton(

                                        color: Colors.white,
                                        child: Text("${ticket['place']['numero']}",
                                          style: TextStyle(color: Colors.green,fontSize: 12),),
                                        onPressed: (){

                                        },

                                      ),
                                    );
                                  return Container();
                                })


                              ],
                            ),

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

    http.get(url2).then((resp) {
      setState(() {
        salle['projections'] = jsonDecode(resp.body)['_embedded']['projections'];
        salle['currentProjection']= salle['projections'][0];
        salle['currentProjection']['listTickets']=[];


      });
    }).catchError((err) {
      print(err);
    });


  }

  void loadTickets(projection,sallee) {
    // String url = "http://192.168.1.8:8080/projections/1/tickets?projection=t1";


    String url = projection['_links']['tickets']['href'].toString().replaceAll("{?projection}", "?projection=t1");
    print(url);
    http.get(url).then((resp){
      setState(() {


        projection['listTickets']=jsonDecode(resp.body)['_embedded']['tickets'];
        sallee['currentProjection']=projection;
        projection['nbrPlaceDispo']=nombrePlaceDisponibles(projection);



      });


    }).catchError((err){
      print(err);

    });
  }
  nombrePlaceDisponibles(projection){
    int nombre = 0 ;

    for(int i = 0;i<projection['tickets'].length;i++){
      if(projection['tickets'][i]['reserve']==false)
        ++nombre;
    }
    return nombre;
  }
}
