
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_app/models/todo.dart';
import '../services/todo_service.dart';





final todoServiceProvider = Provider<TodoService>((ref) => TodoService());

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  final service = ref.read(todoServiceProvider);
  return TodoNotifier(service);
});

// final todoProvider =  StateNotifierProvider<TodoNotifier,List<Todo>>((ref){
//   return TodoNotifier();
// }
// );

class TodoNotifier extends StateNotifier<List<Todo>> {
  final TodoService service;

  TodoNotifier(this.service) : super([]) {
    _startListener(); // Start listening from Firebase
  }

  void _startListener() {
    service.getTodos().listen((firebaseTodos) {
      state = firebaseTodos;
    });
  }

  Future<void> addTask(String task) async {
    final newTask = Todo(
      id: DateTime.now().toIso8601String(),
      task: task,
      isDone: false,
      credential: FirebaseAuth.instance.currentUser!.uid.toString()
    );
    await service.addTodo(newTask);
    // No need to update state manually – listener handles it
  }

  Future<void> deleteTask(String id) async {
    await service.deleteTodo(id);
  }

  Future<void> markDone(String id, bool value) async {
    final updated = state.firstWhere((t) => t.id == id).copyWith(isDone: value);
    await service.updateTodo(updated);
  }
}


// class TodoNotifier extends StateNotifier<List<Todo>> {
//   TodoNotifier() :super([]);
//
//   void addTask(String task) {
//     final newTask = Todo(
//         id: DateTime.now().toString(), task: task, isDone: false);
//     state = [...state, newTask];
//   }
//
//   void deleteTask(String id) {
//     state = state.where((item) => item.id != id).toList();
//   }
//
//   void markDone(String id,bool value) {
//     state = state.map((item) {
//       if (item.id == id) {
//         return item.copyWith(isDone: value);
//       }
//       return item;
//     }).toList();
//   }
// }
//
// final pageProvider = StateProvider<bool>((ref){
//   return false;
// });


