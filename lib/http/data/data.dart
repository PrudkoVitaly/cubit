// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  String name;
  String avatar;
  String description;
  String? id;

  Person({
    required this.name,
    required this.avatar,
    required this.description,
    this.id,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    name: json["name"],
    avatar: json["avatar"],
    description: json["description"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
    "description": description,
    "id": id,
  };
}



