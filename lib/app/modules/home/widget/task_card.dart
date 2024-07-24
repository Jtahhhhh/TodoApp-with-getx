import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_course/app/core/utils/extentions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../data/model/taskModel.dart';
import '../home_controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final TaskModel task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final title = task.tilte;
    var squarewWidth=Get.width -12.0.wp;
    return Container(
      height: squarewWidth/2,
      width: squarewWidth/2,
      margin: EdgeInsets.all(3.0.wp),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 7,
              offset: const Offset(0, 7)
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          StepProgressIndicator(
            totalSteps: 10,
            currentStep: 8,
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end:  Alignment.bottomRight,
              colors: [
                color.withOpacity(0.5),
                color
              ]
            ),
            unselectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end:  Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white,
              ]
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons'),color: color,),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              children: [
                Text("$title",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0.sp
                ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.0.wp,),
                Text("${task.todos?.length ?? 0} Task",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
