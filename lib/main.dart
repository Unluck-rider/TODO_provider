import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sathish_todo/views/add_todo_view.dart';
import 'viewmodels/todo_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: HomeView(),
        routes: {
          '/addTodo': (context) => AddTodoView(),
        },
      );

  }
}
