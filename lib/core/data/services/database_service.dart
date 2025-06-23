import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/core/data/models/todo_model.dart';

class DatabaseService {
  final CollectionReference todoCollection = FirebaseFirestore.instance
      .collection('todos');
  User? user = FirebaseAuth.instance.currentUser!;
  //add task
  Future<DocumentReference> addTask(String title, String description) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //update task
  Future<void> updateTask(String id, String title, String description) async {
    return await todoCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  //update task status
  Future<void> updateTaskStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed': completed});
  }

  //delete task
  Future<void> deleteTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  //get pending tasks
  Stream<List<TodoModel>> get pendingtodos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  //get completed tasks
  Stream<List<TodoModel>> get completedtodos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  List<TodoModel> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TodoModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
