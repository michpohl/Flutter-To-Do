import 'dart:async';
import 'dart:convert';

import 'package:flutter_to_do/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHandler {


  DataBaseHandler();


  void saveTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String taskAsJsonString = json.encode(task);
    print(taskAsJsonString);
    prefs.setString(task.title, taskAsJsonString);
  }


  Future<Set<Task>> getAllTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<Task> taskSet;
    Set<String> taskJsonAsStringSet;

    Set<String> keys = prefs.getKeys();

    keys.forEach((key) => taskJsonAsStringSet.add(prefs.getString(key)));
    // something must be wrong here
    taskJsonAsStringSet.forEach((task) => json.decode(task);


    }
}