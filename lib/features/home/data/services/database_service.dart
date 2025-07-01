import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/features/home/data/models/todo_model.dart';

class DatabaseService {
  final CollectionReference todoCollection = FirebaseFirestore.instance
      .collection('todos');

  // Add task
  Future<DocumentReference> addTask(String title, String description) async {
    final user = FirebaseAuth.instance.currentUser!;
    return await todoCollection.add({
      'uid': user.uid,
      'title': title,
      'description': description,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Update task
  Future<void> updateTask(String id, String title, String description) async {
    return await todoCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  // Update task status
  Future<void> updateTaskStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed': completed});
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  // Get pending tasks stream
  Stream<List<TodoModel>> get pendingtodos {
    final user = FirebaseAuth.instance.currentUser!;
    return todoCollection
        .where('uid', isEqualTo: user.uid)
        .where('completed', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  // Get completed tasks stream
  Stream<List<TodoModel>> get completedtodos {
    final user = FirebaseAuth.instance.currentUser!;
    return todoCollection
        .where('uid', isEqualTo: user.uid)
        .where('completed', isEqualTo: true)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  // Parse Firestore data into TodoModel list
  List<TodoModel> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TodoModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
