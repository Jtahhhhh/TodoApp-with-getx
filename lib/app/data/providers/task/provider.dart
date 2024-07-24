import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_course/app/core/utils/key.dart';
import 'package:getx_course/app/data/services/storage/services.dart';
import '../../model/taskModel.dart';

class TaskProvider{
  final _storageService = Get.find<StorageService>();
//get data from json
  List<TaskModel> readTasks(){
    var tasks = <TaskModel>[];
    for (var e in jsonDecode(_storageService.read(taskKey).toString())) {
      tasks.add(TaskModel.fromJson(e));
    }
    return tasks;
  }

  void writeTasks(List<TaskModel> tasks){
    _storageService.write(taskKey,jsonEncode(tasks));
  }
}