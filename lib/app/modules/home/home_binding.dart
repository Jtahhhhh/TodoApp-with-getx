import 'package:get/get.dart';
import 'package:getx_course/app/data/providers/task/provider.dart';
import 'package:getx_course/app/data/services/storage/reponsitory.dart';
import 'package:getx_course/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController(
        repository: TaskRepository(
            taskProvider: TaskProvider()
        )
      )
    );
  }

}