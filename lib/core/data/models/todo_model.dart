import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final Timestamp timestamp;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.timestamp,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json, String id) {
    return TodoModel(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      completed: json['completed'] ?? false,
      timestamp: json['timestamp'] ?? Timestamp.now(),
    );
  }
}
