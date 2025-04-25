import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoViewModel with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(id: DateTime.now().toString(), title: title, note: ''));
    notifyListeners();
  }

  void addTodoFull(String title, String note) {
    _todos.add(Todo(
      id: DateTime.now().toString(),
      title: title,
      note: note,
      isDone: false,
    ));
    notifyListeners();
  }
  void toggleTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}