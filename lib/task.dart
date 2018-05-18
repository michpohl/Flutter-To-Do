import 'dart:async';

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

class ItemsState {
  List<Task> items;
  bool loading;
  bool error;

  ItemsState({
    this.items = const [],
    this.loading = true,
    this.error = false,
  });

  void reset() {
    this.items = [];
    this.loading = true;
    this.error = false;
  }



  Future <void> getFromApi() async  {
//  this.items = [
//  new Task(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
//  new Task(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
//  new Task(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
//  ];

  DataBaseHandler dh = new DataBaseHandler();
  this.items =  await dh.getAllTasks();
  print(this.items.toString());
  this.loading = false;
  this.error = false;
  }
}