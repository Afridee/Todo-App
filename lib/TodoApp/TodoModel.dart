// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    this.notificationId,
    this.title,
    this.description,
    this.time,
    this.reminder,
  });

  int notificationId;
  String title;
  String description;
  String time;
  bool reminder;

  factory TodoModel.fromJson(Map<dynamic, dynamic> json) => TodoModel(
    notificationId: json["notificationId"],
    title: json["title"],
    description: json["description"],
    time: json["time"],
    reminder: json["reminder"],
  );

  Map<dynamic, dynamic> toJson() => {
    "notificationId": notificationId,
    "title": title,
    "description": description,
    "time": time,
    "reminder": reminder,
  };
}
