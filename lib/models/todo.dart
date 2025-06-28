
class Todo{
  final String id;
  final String task;
  final bool isDone;
  final String credential;
  Todo({required this.id,required this.task,required this.isDone,required this.credential});

  factory Todo.fromJson(Map<String, dynamic> json, String id) {
    return Todo(id: id, task: json['title'], isDone: json['isDone'] ?? false,credential: '');
  }

  Map<String, dynamic> toJson() {
    return {'title': task, 'isDone': isDone,'credential' :credential};
  }

  Todo copyWith({String? id, String? task, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      isDone: isDone ?? this.isDone,
      credential: credential??this.credential
    );
  }
}