import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:getx_course/app/core/values/colors.dart';
import 'package:getx_course/app/data/model/taskModel.dart';
import 'package:getx_course/app/modules/home/home_controller.dart';
import 'package:getx_course/app/core/utils/extentions.dart';
import 'package:getx_course/app/modules/home/widget/add_card.dart';
import 'package:getx_course/app/modules/home/widget/add_dialog.dart';
import 'package:getx_course/app/modules/home/widget/task_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.tasks.length);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text("My List",
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Obx(
              ()=> GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...controller.tasks.map(
                            (e)=>LongPressDraggable(
                              data: e,
                              onDragStarted: ()=> controller.changeDeleting(true),
                              onDragEnd: (_)=>controller.changeDeleting(false),
                                onDraggableCanceled: (_,__)=>controller.changeDeleting(false),
                                feedback: Opacity(
                                  opacity: 0.6,
                                  child: TaskCard(task: e),
                                ),
                                child: TaskCard(task: e)
                            )
                    )
                    .toList(),
                    // TaskCard(
                    //     task:TaskModel(
                    //         tilte: 'Ngon',
                    //         icon: 0xe59c,
                    //         color: "#FFEEC38E"
                    //
                    //     )
                    // ),
                    AddCard()
                  ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        builder: (_, __, ___)
        {
          return Obx(
                () => FloatingActionButton(
                backgroundColor: !controller.deleting.value ?Colors.blue :Colors.red,
                onPressed: () {
                  Get.to(() => AddDialog(),transition: Transition.rightToLeft);
                },
                child: !controller.deleting.value ?Icon(Icons.add,color: Colors.white,): Icon(Icons.delete,color: Colors.white,)
            ),
          );
        },
        onAccept: (TaskModel task){
            controller.deleteTask(task);
            EasyLoading.showSuccess("Complete");
        },

      ),
    );
  }
}
