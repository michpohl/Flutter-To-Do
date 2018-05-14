import 'package:flutter/material.dart';
import 'package:flutter_to_do/todo_start_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp();


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ToDoStartPage()
    );
  }
}