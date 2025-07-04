import 'package:todoapp/features/home/data/models/todo_model.dart';

extension TodoModelExtension on TodoModel {
  String get formattedDate {
    final dt = timestamp.toDate();
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
