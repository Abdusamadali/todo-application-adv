import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';

class TodoService {
  final _collection = FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(Todo todo) async {
    await _collection.doc(todo.id).set(todo.toJson());
  }

  Future<void> deleteTodo(String id) async {
    await _collection.doc(id).delete();
  }

  Future<void> updateTodo(Todo todo) async {
    await _collection.doc(todo.id).update(todo.toJson());
  }

  // Stream<List<Todo>> getTodos() {
  //   return _collection.snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => Todo.fromJson(doc.data(), doc.id)).toList()
  //   );
  // }

  Stream<List<Todo>> getTodos() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _collection
        .where('credential', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data(), doc.id))
        .toList());
  }
}
