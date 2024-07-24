import 'package:getx_course/app/data/model/taskModel.dart';
import 'package:getx_course/app/data/providers/task/provider.dart';


class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({ required this.taskProvider});

  List<TaskModel> readTasks() => taskProvider.readTasks();
  void writeTasks(List<TaskModel> tasks) => taskProvider.writeTasks(tasks);
}