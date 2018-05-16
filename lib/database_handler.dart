import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_to_do/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHandler {


  DataBaseHandler();

  // for testing stuff
  Future pause(Duration d) => new Future.delayed(d);

  Future<void> saveTask(Task task) async {
    print("We're in the save method");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String taskAsJsonString = json.encode(task);
    print("This is the task: " + taskAsJsonString);
    if (task.title != null) {
      prefs.setString(task.title, taskAsJsonString);
      await pause(const Duration(milliseconds: 1000));
    } else {
      print("We're having a task with title null. Skipping it. It's useless!");
    }
  }


  Future<Set<Task>> getAllTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<Task> taskSet = new Set<Task>();
    Set<String> taskJsonAsStringSet = new Set<String>();

    Set<String> keys = prefs.getKeys();
    keys.forEach((key)  =>  print(prefs.getString(key)));
    keys.forEach((key)  =>  taskJsonAsStringSet.add(prefs.getString(key)));
    taskJsonAsStringSet.forEach((task)  =>  taskSet.add(decodeJsonTask(task)));
        return taskSet;

    }

    Task decodeJsonTask(String task) {
      Map decodedTask = json.decode(task);
      print("decoded: " + decodedTask.toString());
    }

}