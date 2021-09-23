
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/screen_utils.dart';

Future<String?> showInputDialog(
  BuildContext context,{
    String? title,
    String? initialValue,
  })async{
  String value = initialValue ?? '';
  TextEditingController controller = TextEditingController();
  controller.text = value;
  final isDarkMode = context.isDarkMode;
  final result = await showCupertinoDialog<String>(
    context:context, 
    builder: (context) => CupertinoAlertDialog(
      title: title!=null?Text(title):null,
      content: CupertinoTextField(
        controller: TextEditingController()..text = initialValue ?? '',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDarkMode ? const Color(0xff37474f) : Colors.black12,
        ),
        onChanged:(text){
            value = text;
        },
        ),
        actions: [
          CupertinoDialogAction(
            onPressed:(){
              Navigator.pop(context,value);
            },
            child: const Text("Guardar"),
            isDefaultAction: true,
            ),
            CupertinoDialogAction(
            onPressed:(){
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
            isDestructiveAction: true,
            ),
        ],
    ),
    );

  

    if(result!=null && result.trim().isEmpty){
        return null;
    }
    return result;
}