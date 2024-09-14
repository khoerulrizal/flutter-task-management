import 'package:flutter/material.dart';
import 'package:task_management/add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Map<String, dynamic>> tasks = [
    {'task': 'Learn Dart Language', 'isDone': true},
    {'task': 'Learn Flutter', 'isDone': false},
  ];

  void _toggleDone(int index) {
    setState(() {
      tasks[index]['isDone'] = !tasks[index]['isDone'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _navigateToAddTaskScreen(BuildContext context) async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
    );
    if (newTask != null) {
      setState(() {
        tasks.add({'task': newTask, 'isDone': false});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddTaskScreen(context),
          ),
        ],
      ),
      body: _buildResponsiveListView(context),
    );
  }

  Widget _buildResponsiveListView(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // For Web or large screens, display as grid
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _buildTaskItem(index);
            },
          );
        } else {
          // For mobile, display as list
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _buildTaskItem(index);
            },
          );
        }
      },
    );
  }

  Widget _buildTaskItem(int index) {
    return ListTile(
      title: Text(
        tasks[index]['task'],
        style: TextStyle(
          decoration: tasks[index]['isDone']
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: tasks[index]['isDone'],
            onChanged: (_) => _toggleDone(index),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTask(index),
          ),
        ],
      ),
    );
  }
}
