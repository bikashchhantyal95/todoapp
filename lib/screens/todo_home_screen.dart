import 'package:flutter/material.dart';
import 'package:todoapp/screens/todo_form.dart';

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

  void _addTodo(String title) {
    setState(() {
      _todos.add({'title': title, 'isCompleted': false});
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index]['isCompleted'] = !_todos[index]['isCompleted'];
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            leading: Checkbox(
                value: todo['isCompleted'],
                onChanged: (_) {
                  _toggleTodo(index);
                }),
            title: Text(
              todo['title'] as String,
              style: TextStyle(
                  decoration: (todo['isCompleted'] as bool)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            trailing: IconButton(
                onPressed: () => _deleteTodo(index),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => TodoForm(onAddTodo: _addTodo));
        },
        tooltip: "Add a new task",
        child: Icon(Icons.add),
      ),
    );
  }
}
