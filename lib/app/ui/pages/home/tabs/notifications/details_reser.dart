
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
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var xfecha;
var  userID;
var titleUser;
var dateUser;
var descripcionUser;

 

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class Notifitabb extends StatefulWidget {
  
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Notifitabb> {
    Map<DateTime,List<Evento>>? selectedEvents;
    LinkedHashMap<DateTime, List<AppEvent>>? _groupedEvents;
   DateTime _focusedDay = DateTime.now();
    DateTime _selectedDay = DateTime.now();
  @override
    void didChangeDependencies() {
      //context.read(pnProvider).init();
      super.didChangeDependencies();  
    }

    int getHashCode(DateTime key){
      return key.day * 1000000 + key.month * 10000 + key.year;
    }

  _groupEvents(List<AppEvent>events){
    
    _groupedEvents = LinkedHashMap(equals: isSameDay,hashCode: getHashCode);
    events.forEach((event) {
      DateTime date = DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      
      if(_groupedEvents![date] == null) _groupedEvents![date] = [];
      _groupedEvents![date]!.add(event);
      
    });

  }

 List<dynamic> _getEventsForDay(DateTime date){
  
     return _groupedEvents?[date]?? [];
  }
        //selector eventos
        @override
        void initState() {
          selectedEvents = {};
          super.initState();
          
        }

        List<Evento> _getEventsfromDay(DateTime date){
          return selectedEvents![date]?? [];
        }

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
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
                         FirebaseFirestore.instance.collection("events").where('user_id', isEqualTo: globalUser)
                         .snapshots(),
                         
                
                    builder: (  context, AsyncSnapshot snapshot){

                      if(snapshot.hasData){
                       List<DocumentSnapshot> events = snapshot.data.docs;        
                        return Container(
                          child: Column(
                            children: [
                              Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8.0),
                    child: TableCalendar(
                          locale: 'es_ES',
                          
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, _selectedDay),
                          firstDay: kFirstDay,
                          lastDay: kLastDay,
                          eventLoader: _getEventsfromDay,
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },

                       
                          
                     weekendDays: [6,7],
                     headerStyle:const HeaderStyle(
                       titleCentered: true,formatButtonVisible: false,
                       decoration:BoxDecoration(
                         color: Colors.blueAccent
                        ),
                          headerMargin: const EdgeInsets.only(bottom: 8.0)
                        ),
                     
                     ),
                  ),
                              ListView.builder(    

                               shrinkWrap: true,
                               physics: NeverScrollableScrollPhysics(),
                                itemCount: events.length,
                                itemBuilder: (_,i){
                                  
                                      Map  data = events[i].data() as Map;                        
                                      dateUser = data['date'];
                                      descripcionUser = data['Descripcion'];
                                      titleUser = data['Titulo'];
                                      var titulo = data['Titulo'];
                                       
                                      
                                        
                                      
                                      return ListTile(
                                        title: Text(data['Titulo']),
                                        subtitle: Text(DateFormat("EEEE, dd,MMMM,yyyy ")
                                        .format(DateTime.fromMicrosecondsSinceEpoch(data['date']) )
                                        ),
                                        onTap: (){
                                              print('Tituloss'+data['Titulo']);
                                        },
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: ()async{

                                  final confirm = await showDialog(
                                    context: context,
                                    builder: (copntext) => AlertDialog(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/images/user/images/sorpendida.png', fit: BoxFit.cover, height: 100)
                                        ],
                                      ),
                                      content: Text("Estas seguro de Eliminar"),
                                      actions: [
                                        TextButton(
                                          
                                          onPressed: () => Navigator.pop(context, true),
                                          child: Text("Eliminar"),
                                          
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: Text("Cancelar",
                                          style: TextStyle(color: Colors.grey.shade700),
                                          ),
                                        ),
                                      ],
                                    ),) ?? false; 
                                  if(confirm){
                                    //delete

                                FirebaseFirestore.instance.collection("events").where('Titulo' 
                                , isEqualTo: titulo).snapshots().listen((rs) { 
                                rs.docs.forEach((element) {
                               
                                        print('titutulo '+data['Titulo']);
                                    print('element.id '+element.id);
                                FirebaseFirestore.instance
                                .collection("events")
                                .doc(element.id)
                                .delete();
                                    
                                      });
                                });
                                 
                                    //Navigator.pop(context);
                                  }
                                },
                                          )
                                      );
                                },                      
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
}   