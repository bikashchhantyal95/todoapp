import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  final Function(String) onAddTodo;
  const TodoForm({super.key, required this.onAddTodo});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final todoTextController = TextEditingController();

  String? _validateTodo(String? title) {
    if (title == null || title.isEmpty) {
      return "Todo title cannot ne empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Add New Task"),
              SizedBox(height: 16),
              TextFormField(
                controller: todoTextController,
                validator: _validateTodo,
                decoration: InputDecoration(
                  labelText: "Task Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onAddTodo(todoTextController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
