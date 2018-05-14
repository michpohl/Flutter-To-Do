import 'package:flutter/material.dart';

class AddTodDoItemDialog extends StatefulWidget {
  @override
  AddToDoItemDialogState createState() => new AddToDoItemDialogState();
}

class AddToDoItemDialogState extends State<AddTodDoItemDialog> {

  String title;
  String description;
  String listName;
  DateTime dueDate;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Add new task'),

        ),
        floatingActionButton: new FloatingActionButton(
            onPressed: null,
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
                    title = text;
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
                  description = text;
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