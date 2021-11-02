import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/foundation.dart';

import 'package:offside_yopal/app/ui/pages/home/tabs/calendar/model/app_event.dart';

import 'data_constants.dart';

final eventDBS = DatabaseService<AppEvent>(
  AppDBConstants.eventsCollection,
  fromDS: (id, data) => AppEvent.fromDS(id, data!),
  toMap: (event) => event.toMap(),
);



class Evento {
  final String title;
  Evento({required this.title,});
    String toString() => this.title;
  
}

