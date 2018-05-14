import 'dart:async';

class ToDoItem {
  final String title;
  final String description;
  final DateTime dueDate;
  final String listName;

  ToDoItem({
    this.title,
    this.description,
    this.dueDate,
    this.listName
  });
}

class ItemsState {
  List<ToDoItem> items;
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

  Future

  <

  void

  >

  getFromApi

  () async

  {
  this.items = [
    new ToDoItem(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
    new ToDoItem(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
    new ToDoItem(title: "Test", description: 'Dies ist ein Test', dueDate: new DateTime.utc(1989, DateTime.november, 9), listName: 'name'),
  ];
  this.loading = false;
  this.error = false;
  }
}