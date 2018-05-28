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
    return new Center(child: new ListView(children: _listOfTaskWidgets()));
  }

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }



  List<Widget> _listOfTaskWidgets() {
    List<Widget> taskWidgets = new List<Widget>();
    tasksState.items.forEach((task) {
      if (task.title != null) {
        taskWidgets.add(new ListTile(
          leading: new Text("Datum"),
          title: new Text(task.title),
          subtitle: new Text("Description"),
//          trailing: new Text("x.listName"),
        trailing: new FlatButton(onPressed: () => _deleteSelectedItem(task), child: new Text("Delete")),
        ));
      }
    });
    return taskWidgets;
  }

  _updateTaskList() async {
    if (!mounted) return;

    await tasksState.getFromApi();
    setState(() {});
  }

  void _deleteSelectedItem(Task task) async{
    DataBaseHandler dh = new DataBaseHandler();
    await dh.deleteTask(task);
    _updateTaskList();
  }

  void _openAddEntryDialog() async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute<dynamic>(
            // remember: using dynamic prevents the navigator assertion error (line 1846)
            builder: (BuildContext context) {
              return new AddTodDoItemDialog();
            },
            fullscreenDialog: true));

    if (result) {
      _updateTaskList();
    }

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('BlaBla')),
        floatingActionButton: new FloatingActionButton(
          onPressed: _openAddEntryDialog,
          child: new Icon(Icons.add),
        ),
        body: _getCurrentStateWidget());
  }
}
