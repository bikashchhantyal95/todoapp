// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Todo {
  String id;
  String title;
  bool isCompleted;
  DateTime completionDate;
  Todo(
      {required this.title,
      this.isCompleted = false,
      required this.completionDate})
      : id = DateFormat('yyyMMddHHmmss').format(DateTime.now());

  void toggleTodo() {
    isCompleted = !isCompleted;
  }
}
