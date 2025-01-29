import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/screens/todo_form.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final List<Todo> _todos = [];

  void _addTodo(String title, DateTime toBeCompletedDate) {
    setState(() {
      _todos.add(Todo(title: title, completionDate: toBeCompletedDate));
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].toggleTodo();
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
      body: _todos.isEmpty
          ? const Center(child: Text("No tasks yet!!"))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) {
                        _toggleTodo(index);
                      }),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                        decoration: (todo.isCompleted)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(todo.completionDate),
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
