import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/database_handler.dart';

class Task {
  String title;
  String description;
  DateTime dueDate;
  String listName;

  Task({
    this.title,
    this.description,
    this.dueDate,
    this.listName
  });

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'description': description,
        'due_date' : dueDate,
        'list_name': listName,
      };

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        dueDate = json['due_date'],
        listName = json['list_name'];
}

// TODO where should I put this class? I feel it's wrong here
class TasksState extends ValueNotifier {
  List<Task> items;
  bool loading;
  bool error;

  TasksState({
    this.items = const [],
    this.loading = true,
    this.error = false,
  }) : super(null);

  void reset() {
    this.items = [];
    this.loading = true;
    this.error = false;
  }

  Future <void> deleteTast(String name) async {
    DataBaseHandler dh = new DataBaseHandler();


  }

  Future <void> getFromApi() async  {

  DataBaseHandler dh = new DataBaseHandler();
  this.items =  await dh.getAllTasks();
  print(this.items.toString());
  this.loading = false;
  this.error = false;
  }
}