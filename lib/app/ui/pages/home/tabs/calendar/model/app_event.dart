import 'dart:convert';

class AppEvent {
  final String title; 
  final String id;
  final String descripcion;
  final DateTime date;
  final String userId;
  final bool public;


  AppEvent({
    required this.title,
    required this.id,
    required this.descripcion,
    required this.date,
    required this.userId,
     required this.public,
  });

  AppEvent copyWith({
    String? title,
    String? id,
    String? descripcion,
    DateTime? date,
    String? userId,
    bool? public,
  }) {
    return AppEvent(
      title: title ?? this.title,
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      public: public ?? this.public,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'descripcion': descripcion,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'public': public,
    };
  }

  factory AppEvent.fromMap(Map<String, dynamic> map) {
            
    return AppEvent(
      title: map['title'],
      id: map['id'],
      descripcion: map['descripcion'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      public: map['public'],
    );
  }

  factory AppEvent.fromDS(String id, Map<String, dynamic> map) {
     
    return AppEvent(
      title: map['title'],
      id: id,
      descripcion: map['descripcion'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      public: map['public'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppEvent.fromJson(String source) => AppEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppEvent(title: $title, id: $id, descripcion: $descripcion, date: $date, userId: $userId, public: $public)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppEvent &&
      other.title == title &&
      other.id == id &&
      other.descripcion == descripcion &&
      other.date == date &&
      other.userId == userId &&
      other.public == public;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      id.hashCode ^
      descripcion.hashCode ^
      date.hashCode ^
      userId.hashCode ^
      public.hashCode;
  }
}
