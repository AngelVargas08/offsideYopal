
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/add_event.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/model/app_event.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/services/event_firestore_service.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var xfecha;
var  userID;
var titleUser;
var dateUser;
var dateUser2;
var descripcionUser;
var selet;
var temp = '';
int w = 0;
var qq;

 

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class Notifitabb extends StatefulWidget {
  
  @override
  _CalendarState createState() => _CalendarState();
}


class _CalendarState extends State<Notifitabb> {
  void changeValor(){
  setState((){
    temp = w.toString();
  });
}
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Reservas'),
        backgroundColor: Colors.green.shade600,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[        
              StreamBuilder(       
                    stream:              
                         FirebaseFirestore.instance.collection("events")
                         .where('Titulo', isEqualTo: globalUser)
                         .snapshots(),     

                    builder: (  context, AsyncSnapshot snapshot){

                      if(snapshot.hasData){
                       List<DocumentSnapshot> events = snapshot.data.docs;        
                        return Container(
                          
                          child: Column(
                            children: [
                              SizedBox(height: 100,),
                              const Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(8.0),
                    
                   child: MyStatefulWidget(),
                          
                  ),
                  SizedBox(height: 100,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          
                          children: [
                            
                            RaisedButton(
                                color: pressButton[0] ? Colors.grey : Colors.green,
                                textColor: Colors.white,
                                child: Text(
                                  'Buscar',
                                  style: TextStyle(fontSize: 17),
                                ),
                                onPressed: (){
                                  changeValor();
                               FirebaseFirestore.instance.collection("events")
                                .where('Titulo', isEqualTo: globalUser)
                                .snapshots().listen((event) {
                                  event.docs.forEach((element) {
                                    var y = element.data()['date'];
                                  var t = DateFormat("MMMM")
                                        .format(DateTime.fromMicrosecondsSinceEpoch(y));
                                                int i =0;
                                       
                                      // print(t);
                                            
                                       if( t == selet){
                                          w ++;
                                       }

                                  }
                                  ); temp = 'En el mes de '+ qq + ' se reservaron '+ w.toString()+' canchas';
                                  print(w);
                                  w = 0;
                                }
                                );
                               
                                }
                                ),
                          ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200,),
                  Container(
                    child: Column(
                      children: [
                        
                        Text(temp,
                        style: TextStyle(fontSize: 16),)
                      ],),
                  ),
                             
                            ],
                          ),
                        );
                      }
                    //  }
                      return 
                       SizedBox(
                         height: MediaQuery.of(context).size.height/1.3,
                         child: Center(
                           child: CircularProgressIndicator()
                           ,)
                         );
                    },
                  ),
              ],
            );
          }
        ),
      ),

          

     
    );
}
          }  class MyStatefulWidget extends StatefulWidget {
            const MyStatefulWidget({Key? key}) : super(key: key);

            @override
            State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
          }

          /// This is the private State class that goes with MyStatefulWidget.
          class _MyStatefulWidgetState extends State<MyStatefulWidget> {
            String dropdownValue = 'Enero';
                    
            @override
            Widget build(BuildContext context) {
              return DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.green),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Enero', 'Febrero', 'Marzo', 'Abril','Mayo',
                'Junio', 'Julio', 'Agosto','Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
                    .map<DropdownMenuItem<String>>((String value) {
                    List<String> es = ['Enero', 'Febrero', 'Marzo', 'Abril','Mayo','Junio', 'Julio', 'Agosto','Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
                    List<String> en = ['January', 'February', 'March', 'April','May','June', 'July', 'August','September', 'October', 'November', 'December'];
                    for(var i=0; i<es.length; i++){
                      if(dropdownValue==es[i]){
                        selet=en[i];
                      }
                    }
                      qq = dropdownValue;
              
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 25),) ,
                    
                  );
                }).toList(),
              );
  } }