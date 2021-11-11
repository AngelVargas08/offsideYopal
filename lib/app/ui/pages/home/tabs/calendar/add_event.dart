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
List<bool> pressButton = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];

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
                         
                       fechadb = DateFormat("EEEE, dd,MMMM,yyyy ")
                          .format(DateTime.fromMicrosecondsSinceEpoch(element['date']) );
                          w = element['descripcion'];
                          
                          
                          
                       });
                      });
                        
                        

                      if(w == hour ){
                        
                      
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
        
        title: Text('Agendar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
         FormBuilder(
           key: _formKey,
           child: Column(
             children: [
                FormBuilderTextField(
                  
                  enabled: false,
                  enableInteractiveSelection: false,
                  //keyboardType: TextInputType.none,
                  name: 'Titulo',
                 initialValue: emailcan,

                  
                  ),
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
                  //format: DateFormat('EEEE, dd MMMM, yyyy'),
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
                            color: pressButton[0] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '07:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=0){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[0]=!pressButton[0];
                              });
                              hour = '7:00 AM';
                              
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[1] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '08:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=1){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[1]=!pressButton[1];
                              });
                              hour = '8:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[2] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '09:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=2){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[2]=!pressButton[2];
                              });
                              hour = '9:00 AM';
                            }
                            ),
                            
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: pressButton[3] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '10:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=3){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[3]=!pressButton[3];
                              });
                              hour = '10:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[4] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '11:00 AM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=4){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[4]=!pressButton[4];
                              });
                              hour = '11:00 AM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[5] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '12:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=5){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[5]=!pressButton[5];
                              });
                              hour = '12:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: pressButton[6] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '01:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=6){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[6]=!pressButton[6];
                              });
                              hour = '1:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[7] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '02:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=7){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[7]=!pressButton[7];
                              });
                              hour = '2:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[8] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '03:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=8){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[8]=!pressButton[8];
                              });
                              hour = '3:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: pressButton[9] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '04:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=9){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[9]=!pressButton[9];
                              });
                              hour = '4:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[10] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '05:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=10){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[10]=!pressButton[10];
                              });
                              hour = '5:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[11] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '06:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=11){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[11]=!pressButton[11];
                              });
                              hour = '6:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: pressButton[12] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '07:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=12){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[12]=!pressButton[12];
                              });
                              hour = '7:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[13] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '08:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=13){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[13]=!pressButton[13];
                              });
                              hour = '8:00 PM';
                            }
                            ),
                            SizedBox( width: 15,),
                            RaisedButton(
                            color: pressButton[14] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '09:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=14){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[14]=!pressButton[14];
                              });
                              hour = '9:00 PM';
                            }
                            ),
                        ],
                        
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            color: pressButton[15] ? Colors.grey : Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              '10:00 PM',
                              style: TextStyle(fontSize: 17),
                            ),
                            onPressed: (){
                              setState(() {
                                for(var i =0; i <pressButton.length; i++){
                                  if(i!=15){
                                    pressButton[i]=false;
                                  }
                                }
                                pressButton[15]=!pressButton[15];
                              });
                              hour = '10:00 PM';
                            }
                            ),
                        ],
                      )
                    ],
                  ),
                    /*Divider(),
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
                      ),*/
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