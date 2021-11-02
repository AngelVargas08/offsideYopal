


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/calendar.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/model/app_event.dart';
import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/services/event_firestore_service.dart';

class EventDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: (){},
            ),
             IconButton(
                icon: Icon(Icons.delete),
                onPressed: ()async{
                  final confirm = await showDialog(
                    context: context,
                    builder: (copntext) => AlertDialog(
                      title: Text("Cuidado"),
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
                     print('Si entra');
                     Navigator.pop(context);
                   }
                },
            ),
          ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children:<Widget> [
          //Text(event.public? "public" : "private"),
          ListTile(
            leading: Icon(Icons.event),
            title: Text(titleUser, style: Theme.of(context)
            .textTheme.headline5,),
            subtitle: Text(DateFormat("EEEE, dd,MMMM,yyyy 'x' hh:mm a")
                                .format(DateTime.fromMicrosecondsSinceEpoch(dateUser) ),
            ),
            
          ),
          const SizedBox(height: 10.0),
          if(descripcionUser != null)
          ListTile(
            leading: Icon(Icons.short_text ),
            title: Text(descripcionUser),
          ),
          const SizedBox(height: 20.0,)
        ],
        ),
    );
}
}