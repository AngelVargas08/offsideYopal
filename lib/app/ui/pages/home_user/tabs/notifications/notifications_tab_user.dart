
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';



class NotifitabUser extends StatelessWidget {
  const NotifitabUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            
      backgroundColor: kPrimaryColor,
      elevation: 0,
       title: Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Text('Mis reservas')
        ],
        
       ),
      
    ),
      
    body: 
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[        
              StreamBuilder(       
                    stream:              
                         FirebaseFirestore.instance.collection("events")
                         .where('user_id', isEqualTo: globalUser)
                         .snapshots(),
                         
                
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

                                      return ListTile(
                                      
                                        title: Text(data['Titulo']),
                                        subtitle: Text(DateFormat("EEEE, dd,MMMM,yyyy ")
                                        .format(DateTime.fromMicrosecondsSinceEpoch(data['date']) ),
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
            ));
    
    
  
   
  }

}