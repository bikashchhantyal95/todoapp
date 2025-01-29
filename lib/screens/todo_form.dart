import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatefulWidget {
  final Function(String, DateTime) onAddTodo;
  const TodoForm({super.key, required this.onAddTodo});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final todoTextController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickDate() async {
    final DateTime? toBeCompletedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (toBeCompletedDate != null && toBeCompletedDate != _selectedDate) {
      setState(() {
        _selectedDate = toBeCompletedDate;
      });
    }
  }

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
                children: [
                  Text(_selectedDate == null
                      ? "Select Completion Date"
                      : DateFormat.yMMMd().format(_selectedDate!)),
                  IconButton(
                    onPressed: _pickDate,
                    icon: Icon(Icons.calendar_today),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
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
                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        widget.onAddTodo(
                            todoTextController.text, _selectedDate!);
                        Navigator.pop(context);
                      } else if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please choose a completion date.")));
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
