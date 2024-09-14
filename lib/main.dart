import 'package:flutter/material.dart';
import 'package:task_management/task_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tast Management App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: TaskListScreen(),
    );
  }
}
