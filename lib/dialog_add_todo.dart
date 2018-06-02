import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_to_do/database_handler.dart';
import 'package:flutter_to_do/task.dart';

class AddTodDoItemDialog extends StatefulWidget {
  @override
  AddToDoItemDialogState createState() => new AddToDoItemDialogState();
}

class AddToDoItemDialogState extends State<AddTodDoItemDialog> {
  String _title;
  String _description;
  String _listName;
  DateTime _dueDate;
  bool hasTaskName = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isWorking = false;

  Future<bool> _taskNameAlreadyTaken(_title) async {
    DataBaseHandler dh = new DataBaseHandler();
    List<Task> savedTasks = await dh.getAllTasks();
    bool taskNameAlreadyTaken = false;

    savedTasks.forEach((task) {
      if (task.title == _title) {
        taskNameAlreadyTaken = true;
      }
    });
    return taskNameAlreadyTaken;
  }

  void _saveTaskAndReturn() async {
    isWorking = true;
    DataBaseHandler dh = new DataBaseHandler();
    Task newTask = new Task(
      title: _title,
      description: _getDescription(),
      listName: _getListName(),
      dueDate: _getDueDate(),
    );
    print(json.encode(newTask).toString());
    await dh.saveTask(newTask);

    Navigator.pop(context, true);
    dh.getAllTasks();
    isWorking = true;
  }


  String _getDescription() {
    return _description ?? "No description entered.";
  }

  String _getListName() {
    return _listName ?? "No list selected";
  }

  DateTime _getDueDate() {
    return _dueDate;
  }

  Widget _getCurrentStateWidget() {
    if (isWorking) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return _interfaceTree();
    }
  }

  Widget _interfaceTree() {
    return new Column(
      children: <Widget>[
        new ListTile(
          title: new Text('Name'),
          subtitle: new TextField(
              controller: null,
              decoration: new InputDecoration(),
              focusNode: null,
              style: null,
              onSubmitted: (text) {
                _title = text;
                hasTaskName = true;
              }),
        ),
        new ListTile(
          title: new Text('Description'),
          subtitle: new TextField(
            controller: null,
            decoration: new InputDecoration(),
            focusNode: null,
            style: null,
            onSubmitted: (text) {
              _description = text;
            },
          ),
        ),
        new ListTile(
            title: new Text('List'),
            subtitle: new FlatButton(
                onPressed: null, child: new Text('Select List'))),
        new ListTile(
            title: new Text('Due date (optional)'),
            subtitle: new FlatButton(
                onPressed: null, child: new Text('Select due date'))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasTaskName) {
      return new Scaffold(
          appBar: new AppBar(
            title: const Text('Add new task'),
          ),
          floatingActionButton: new Builder(
            // Create an inner BuildContext so that the onPressed methods
            // can refer to the Scaffold with Scaffold.of().
            builder: (BuildContext context) {
              return new FloatingActionButton(
                child: new Icon(Icons.check),
                onPressed: () async {
                  if (await _taskNameAlreadyTaken(_title) == true) {
                    Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text('This name is already taken.'),
                        ));
                  } else {
                    print("else");
                    _saveTaskAndReturn();
                  }
                },
              );
            },
          ),

//
          body: _getCurrentStateWidget());
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: const Text('Add new task'),
          ),
          body: _getCurrentStateWidget());
    }
  }
}
