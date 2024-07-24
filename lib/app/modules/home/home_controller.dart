import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_course/app/data/model/taskModel.dart';
import 'package:getx_course/app/data/services/storage/reponsitory.dart';

class HomeController extends GetxController{
  TaskRepository repository;
  HomeController({required this.repository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <TaskModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(repository.readTasks());
    ever(tasks,(_) => repository.writeTasks(tasks));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value){
    chipIndex.value = value;
  }

  void changeDeleting(bool value){
    deleting.value = value;
  }

  bool addTask(TaskModel task){
    if(tasks.contains(task))
      return false;
    tasks.add(task);
    return true;
  }

  void deleteTask(TaskModel task) {
    tasks.remove(task);
  }
}