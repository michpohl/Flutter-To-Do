import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/database_handler.dart';
import 'package:flutter_to_do/dialog_addtodo.dart';
import 'package:flutter_to_do/task.dart';

class ToDoStartPage extends StatefulWidget {
  @override
  _ToDoStartPageState createState() => new _ToDoStartPageState();
}

class _ToDoStartPageState extends State<ToDoStartPage> {
  final TasksState tasksState = new TasksState();

  Widget _getLoadingSteWidget() {
    return new Center(child: new CircularProgressIndicator());
  }

  Widget _getCurrentStateWidget() {
    Widget currentStateWidget;

    if (!tasksState.error && !tasksState.loading) {
      currentStateWidget = _getSuccessStateWidget();
    } else {
      currentStateWidget = _getLoadingSteWidget();
    }
    return currentStateWidget;
  }

  Widget _getSuccessStateWidget() {
    tasksState.items.forEach((x) => print(x.title.toString()));
    return new Center(child: new Column(children: _listOfTaskWidgets()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItems();
  }

  List<Widget> _listOfTaskWidgets() {
    List<Widget> taskWidgets = new List<Widget>();
    tasksState.items.forEach((x) {
      if (x.title != null) {
        taskWidgets.add(new ListTile(
          leading: new Text("Datum"),
          title: new Text("x.title"),
          subtitle: new Text("Description"),
          trailing: new Text("x.listName"),
        ));
      }
    });
    return taskWidgets;
  }

  _getItems() async {
    if (!mounted) return;
    await tasksState.getFromApi();
    setState(() {});
  }

  void _openAddEntryDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddTodDoItemDialog();
        },
        fullscreenDialog: true));
  }

  Future<List<Task>> _testGetAll() {
    var dh = new DataBaseHandler();
    return dh.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('BlaBla')),
        floatingActionButton: new FloatingActionButton(
//            onPressed: _openAddEntryDialog,
          onPressed: _testGetAll,
          child: new Icon(Icons.add),
        ),
        body: _getCurrentStateWidget());
  }
}
