
class Todo{
  final String id;
  final String task;
  final bool isDone;

  Todo({required this.id,required this.task,required this.isDone});

  factory Todo.fromJson(Map<String, dynamic> json, String id) {
    return Todo(id: id, task: json['title'], isDone: json['isDone'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'title': task, 'isDone': isDone};
  }

  Todo copyWith({String? id, String? task, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
    );
  }
}