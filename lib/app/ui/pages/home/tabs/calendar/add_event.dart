import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:offside_yopal/app/data/repositories_impl/autenticacion_repositorio_impl.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/calendar.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/services/event_firestore_service.dart';
import 'package:offside_yopal/app/ui/pages/home_user/view/constants.dart';
import 'package:url_launcher/url_launcher.dart';

var data;
int selectedValue = 0;
Color color= kblackColor;
var hour = '';
 var w = '';
 var fechadb = '';
 String? fecha;
bool cambio = false;


class AddEvent extends StatefulWidget {
 
  const AddEvent({ Key? key, 
    }) : super(key: key); 

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
       leading: IconButton(
        icon: Icon(Icons.clear,
        color: kblackColor,),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
        actions:[
         
          Center(
          
            child: ElevatedButton(
                     
              onPressed: ()async{
                      
                   FirebaseFirestore.instance.collection('events').where(
                     'descripcion', isEqualTo: hour).snapshots().listen((kk) {
                       kk.docs.forEach((element) {  
                         print('*********');
                         print(element.data());
                       fechadb = DateFormat("EEEE, dd,MMMM,yyyy ")
                          .format(DateTime.fromMicrosecondsSinceEpoch(element['date']) );
                          w = element['descripcion'];
                          
                          
                          
                       });
                      });
                        
                        

                      if(w == hour ){
                        
                        print('no deberia');
                        showDialog(
                          context: context,
                           builder: (copntext) => AlertDialog(
                                      
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/images/user/images/triste.png', fit: BoxFit.cover, height: 100)
                                            ],
                                          ),
                                          Row(
                                            
                                            children: [
                                               Text("Este horario no esta disponible"),
                                                     ],
                                          )
                                        ],
                                      ),
                                      
                                      )
                                      );
                      }else{
                print('********guarda*********');
                        

                //guardar
                bool validated = _formKey.currentState!.validate();
                if(validated){
                  _formKey.currentState!.save();
                   data = Map<String,dynamic>.from(
                    _formKey.currentState!.value
                    );
                    data['date'] = (data['date']as DateTime)
                    .microsecondsSinceEpoch;
                    data['user_id'] = globalUser;
                    data['descripcion']= hour;
                    await eventDBS.create(data);
                    Navigator.pop(context);
                    
                   // fecha = (data['date']);
                }
                
               final con = await showDialog(
                     context: context,
                    builder: (copntext) => AlertDialog(
                      title: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image.asset('assets/images/user/images/Feliz.png', fit: BoxFit.cover, height: 100)
                     ],
                      ),
                       content: Text("Tu reserva fue un exito, verificaremos tu pago"),
                       actions: [
                         
                         
                         
                       ],
                     ),) ;
               
                }
              },
              
              child: Text('Guardar'),
              
            ),
          ),

          
        ],
        
        title: Text('Agendar Cita'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
         FormBuilder(
           key: _formKey,
           child: Column(
             children: [
                FormBuilderTextField(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  
                  name: 'Titulo',
                  
                 // initialValue: 'Hola '+ globalUser + ' ,selecciona tu horario.',
                  decoration: const InputDecoration(
                   hintText: 'Agregar cita',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    
                  )
                  ,),
                  Divider(),
                  FormBuilderDateTimePicker(
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context)
                        ]),
                         name: "date",
                  initialValue: xfecha ??
                      DateTime.now(),
                  initialDate: DateTime.now(),
                  fieldHintText: "Add Date",
                  initialDatePickerMode: DatePickerMode.day,
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.calendar_today_sharp),
                  ),
                ),
                  
                  SizedBox( height: 20,),

                  Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '07:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              
                              hour = '7:00 AM';
                              
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '08:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '8:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '09:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '9:00 AM';
                            }
                            ),
                            
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '10:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '10:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '11:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '11:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '12:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '12:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '01:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '1:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '02:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '2:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '03:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '3:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '04:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '4:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '05:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '5:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '06:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '6:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '07:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '7:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '08:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '8:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '09:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '9:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: color,
                            textColor: Colors.white,
                            child: Text(
                              '10:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              hour = '10:00 PM';
                            }
                            ),
                        ],
                      )
                    ],
                  ),
                    Divider(),
                    FormBuilderSwitch(
                    
                      name: 'Public', 
                      title: Text('¿Pagar al ingresar?'),
                      initialValue: false,
                      controlAffinity: ListTileControlAffinity.leading,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        ),
                      ),
                      Divider(),

                  Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            GestureDetector(
                                  onTap: () {
                                     launch('https://biz.payulatam.com/L0e8a34EDFE0EDF');
                                  },
                                  child: Image(
                                    image: AssetImage('assets/images/user/images/boton_pagar.png'),
                                  fit: BoxFit.cover,
                                   height: 90,
                                  )
                            )
                        ],
                      )
                      
                      
                        
             ],
             )
           )
        ],
      ),
    );
}
}