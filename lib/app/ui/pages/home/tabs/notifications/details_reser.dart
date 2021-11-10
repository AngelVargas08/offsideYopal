
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:offside_yopal/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;


class Notifitabb extends StatelessWidget {
  const Notifitabb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            
      backgroundColor: kPrimaryColor,
      elevation: 0,
       title: Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text('Detalles Reservas')
        ],
        
       ),
      
    ),
      
    body: 
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[        
              StreamBuilder(       
                    stream:              
                         FirebaseFirestore.instance.collection("events").snapshots(),

                    builder: (  context, AsyncSnapshot snapshot){

                      if(snapshot.hasData){
                       List<DocumentSnapshot> events = snapshot.data.docs;        
                        return Container(
                          child: Column(
                            children: [
                             
                              ListView.builder(    

                               shrinkWrap: true,
                               physics: NeverScrollableScrollPhysics(),
                                itemCount: events.length,
                                itemBuilder: (_,i){
                                  
                                      Map  data = events[i].data() as Map;  
                                       var titulo = data['Titulo']; 
                                       print('cantidad');                     
                                          print(events.length);
                                      return ListTile(
                                      
                                        title: Text(data['Titulo']),
                                        subtitle: Text(DateFormat("EEEE, dd,MMMM,yyyy ")
                                        .format(DateTime.fromMicrosecondsSinceEpoch(data['date']) ),
                                        ),
  
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
            ),

           
            );
    
    
  
   
  }

}