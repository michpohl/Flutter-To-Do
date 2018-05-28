import 'dart:async';
import 'dart:convert';

import 'package:flutter_to_do/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHandler {
  DataBaseHandler();

  // for testing stuff
  Future pause(Duration d) => new Future.delayed(d);

//  TODO prevent saving two tasks with thesame title
  Future<void> saveTask(Task task) async {
    print("We're in the save method, saving task with name: " + task.title);
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

  Future<void> deleteTask(Task task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(task.title) != null) {
      print("This task exists in prefs.");
      await prefs.remove(task.title);
    }
    if (prefs.getString(task.title) != null) {
      print ("This task still exists in prefs. This is an error"); }
//
//    print("We're in the delete method, deleting the task named: " +
//        task.title.toString());
//    List<Task> currentTasks = await getAllTasks();
//    int taskIndex = _indexOfTaskInTaskList(currentTasks, task.title);
//print("index of that task is: "+ taskIndex.toString());
//    if ( taskIndex != -1) {
//      print("Removing task from List...");
//      print("before removal: " + currentTasks.length.toString());
//      currentTasks.removeAt(taskIndex);
//      print ("after removal: " + currentTasks.length.toString());
//    }
//
//
//    _saveNewTasklist(currentTasks);
  }

  int _indexOfTaskInTaskList(List<Task> taskList, String name) {
    int result = -1;
    taskList.forEach((task) {
      if (task.title == name) {
        print("Found a saved task with name: " + task.title.toString());
        if (task.title == name) result = taskList.indexOf(task);
      }
    });
    return result;
  }

  void _saveNewTasklist(List<Task> taskList) {
    taskList.forEach((task) => saveTask(task));
  }

  Future<List<Task>> getAllTasks() async {
    List<Task> taskSet = new List<Task>();
    List<String> taskJsonAsStringSet = new List<String>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();
    keys.forEach((key) => print(prefs.getString(key)));
    keys.forEach((key) => taskJsonAsStringSet.add(prefs.getString(key)));
    taskJsonAsStringSet.forEach((task) {
      taskSet.add(decodeJsonTask(task));
//      print("Adding task: " + decodeJsonTask(task).title.);
    });
    print("getAllTasks done.");
    return taskSet;
  }

  Task decodeJsonTask(String task) {
    Map decodedTask = json.decode(task);
    Task resultTask = new Task();
    print("decoded: " + decodedTask.toString());
    decodedTask.forEach((key, value) {
      switch (key) {
        case "title":
          resultTask.title = value;
          break;
        case "description":
          resultTask.description = value;
          break;
        case "due_date":
          resultTask.dueDate = value;
          break;
        case "list_name":
          resultTask.listName = value;
          break;
      }
    });

    return resultTask;
  }
}
