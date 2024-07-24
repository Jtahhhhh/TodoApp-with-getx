import 'package:equatable/equatable.dart';

class TaskModel extends Equatable{
  final String tilte;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const TaskModel({
    required this.tilte,
    required this.icon,
    required this.color,
    this.todos
});

  TaskModel copyWith({
    String? tilte,
    int? icon,
    String? color,
    List<dynamic>? todos,
})=> TaskModel(
    tilte: tilte ?? this.tilte,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    todos: todos ?? this.todos
  );

  factory TaskModel.fromJson(Map<String,dynamic> json)
    => TaskModel(
        tilte: json["tilte"],
        icon: json["icon"],
        color: json["color"],
        todos: json["todos"],
    );
  Map<String, dynamic> toJson()=>{
    'title': tilte,
    'icon': icon,
    'color': color,
    'todos': todos,
  };

  @override
  List<Object?> get props => [tilte, icon, color];
}