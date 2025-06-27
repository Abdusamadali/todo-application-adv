
import 'package:riverpod/riverpod.dart';
import 'package:todo_app/models/todo.dart';


final todoProvider =  StateNotifierProvider<TodoNotifier,List<Todo>>((ref){
  return TodoNotifier();
}
);

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() :super([]);

  void addTask(String task) {
    final newTask = Todo(
        id: DateTime.now().toString(), task: task, isDone: false);
    state = [...state, newTask];
  }

  void deleteTask(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void markDone(String id,bool value) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(isDone: value);
      }
      return item;
    }).toList();
  }
}