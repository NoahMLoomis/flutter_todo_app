import 'package:flutter/material.dart';

import '../models/todo.dart';

class MyAppState extends ChangeNotifier {
  List<Todo> todos = [];

  void addItem(String title) {
    todos.add(Todo(title: title, selected: false));
    notifyListeners();
  }

  void removeItem(Todo todo) {
    todos.removeWhere((element) => element == todo);
    notifyListeners();
  }

  void toggleItem(Todo todo) {
    todo.toggleSelected();
    notifyListeners();
  }

  void handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Todo item = todos.removeAt(oldIndex);
    todos.insert(newIndex, item);
    notifyListeners();
  }
}
