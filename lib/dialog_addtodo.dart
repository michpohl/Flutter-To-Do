import 'package:flutter/material.dart';
import 'package:flutter_to_do/task.dart';
import 'package:flutter_to_do/database_handler.dart';


class AddTodDoItemDialog extends StatefulWidget {
  @override
  AddToDoItemDialogState createState() => new AddToDoItemDialogState();
}

class AddToDoItemDialogState extends State<AddTodDoItemDialog> {

  String _title;
  String _description;
  String _listName;
  DateTime _dueDate;

  void _saveTaskAndReturn() {

    DataBaseHandler dataHandler = new DataBaseHandler();
    Task newTask = new Task(
      title: _title,
      description: _description,
      listName: _listName,
      dueDate: _dueDate,
    );

    dataHandler.saveTask(newTask);

    Navigator.of(context).pop(null);
    dataHandler.getAllTasks();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Add new task'),

        ),
        floatingActionButton: new FloatingActionButton(
            onPressed: _saveTaskAndReturn,
            child: new Icon(Icons.check)),
        body: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text ('Name'),
              subtitle: new TextField(
                  controller: null,
                  decoration: new InputDecoration(

                  ),
                  focusNode: null,
                  style: null,
                  onSubmitted: (text) {
                    _title = text;
                  }),

            ),
            new ListTile(
              title: new Text ('Description'),
              subtitle: new TextField(
                controller: null,
                decoration: new InputDecoration(

                ),
                focusNode: null,
                style: null,
                onSubmitted: (text) {
                  _description = text;
                },
              ),
            ),
            new ListTile(
                title: new Text ('List'),
                subtitle: new FlatButton(
                    onPressed: null,
                    child: new Text('Select List'))
            ),
            new ListTile(
                title: new Text ('Due date (optional)'),
                subtitle: new FlatButton(
                    onPressed: null,
                    child: new Text('Select due date'))
            ),

          ],
        )


    );
  }


}