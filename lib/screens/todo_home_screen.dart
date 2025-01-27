import 'package:flutter/material.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final List _todos = [
    {'title': 'Buy groceries', 'isCompleted': false},
    {'title': 'Finish Flutter project', 'isCompleted': true},
    {'title': 'Call the plumber', 'isCompleted': false},
    {'title': 'Go to the gym', 'isCompleted': true},
    {'title': 'Prepare dinner', 'isCompleted': false},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Expanded(
          child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  leading:
                      Checkbox(value: todo['isCompleted'], onChanged: null),
                  title: Text(
                    todo['title'] as String,
                    style: TextStyle(
                        decoration: (todo['isCompleted'] as bool)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                );
              })),
    );
  }
}
