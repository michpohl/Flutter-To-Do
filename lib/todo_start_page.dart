import 'package:flutter/material.dart';
import 'package:flutter_to_do/dialogs.dart';
import 'package:flutter_to_do/todo_item.dart';

class ToDoStartPage extends StatefulWidget {

  @override
  _ToDoStartPageState createState() => new _ToDoStartPageState();
}

class _ToDoStartPageState extends State<ToDoStartPage> {
  final ItemsState itemsState = new ItemsState();

  Widget _getLoadingSteWidget() {
    return new Center(
        child: new CircularProgressIndicator()
    );
  }

  Widget _getCurrentStateWidget() {
    Widget currentStateWidget;

    if (!itemsState.error && !itemsState.loading) {
      currentStateWidget = _getSuccessStateWidget();
    } else {
      currentStateWidget = _getLoadingSteWidget();
    }
    return currentStateWidget;
  }

  Widget _getSuccessStateWidget() {
    return new Center(
        child: new Text(itemsState.items.length.toString() + ' items found!')
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItems();
  }

  _getItems() async {
    if (!mounted) return;

    await itemsState.getFromApi();
    setState(() {

    });
  }
  void _openAddEntryDialog() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('BlaBla')),
        floatingActionButton: new FloatingActionButton(
            onPressed: _openAddEntryDialog,
            child: new Icon(Icons.add),
        ),
        body: _getCurrentStateWidget()
    );
  }
}