/// id : 0
/// created_at : "2025-05-09T21:24:04.899Z"
/// updated_at : "2025-05-09T21:24:04.899Z"
/// is_active : true
/// name : "string"
/// description : "string"
/// event_date : "2025-05-09"
/// family : 0
library;

class EventModel {
  EventModel({
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.isActive, 
      this.name, 
      this.description, 
      this.eventDate, 
      this.family,});

  EventModel.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    description = json['description'];
    eventDate = json['event_date'];
    family = json['family'];
  }
  num? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? description;
  String? eventDate;
  num? family;
EventModel copyWith({  num? id,
  String? createdAt,
  String? updatedAt,
  bool? isActive,
  String? name,
  String? description,
  String? eventDate,
  num? family,
}) => EventModel(  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  isActive: isActive ?? this.isActive,
  name: name ?? this.name,
  description: description ?? this.description,
  eventDate: eventDate ?? this.eventDate,
  family: family ?? this.family,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_active'] = isActive;
    map['name'] = name;
    map['description'] = description;
    map['event_date'] = eventDate;
    map['family'] = family;
    return map;
  }

}