import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_course/app/core/utils/extentions.dart';
import 'package:getx_course/app/modules/home/home_controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    print(homeCtrl.task.value);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
            homeCtrl.editController.clear();
            homeCtrl.changeTask(null);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 3.0.wp),
            child: TextButton(
                onPressed: (){
                if(homeCtrl.formKey.currentState!.validate()){
                  if(homeCtrl.task.value == null){
                    EasyLoading.showError("Please select your task");
                  }
                  else{
                    var taskValue = homeCtrl.task.value;
                    if(taskValue != null){
                      var success = homeCtrl.updateTask(
                        taskValue,
                        homeCtrl.editController.text,
                      );
                      if(success){
                        EasyLoading.showSuccess("Success");
                        Get.back();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      }
                    }


                  }
                }
                },
                child: Text("Done",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0.sp
                  ),
                ),
            ),
          )
        ],
      ),
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  5.0.wp),
              child: Text("New Stask",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                autofocus: true,
                validator: (value){
                  if( value == null || value.trim().isEmpty){
                    return "Please enter your todo";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!
                    )
                  )
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.only(
                top: 5.0.wp,
                left: 5.0.wp,
                right: 5.0.wp,
                bottom: 2.0.wp
              ),
              child: Text("Add to",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey
                ),
              ),
            ),
            ...homeCtrl.tasks.map(
                    (e)=>Obx(
                      () => InkWell(
                        onTap: (){
                          homeCtrl.changeTask(e);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 5.0.wp
                          ),
                          decoration: BoxDecoration(
                            color: homeCtrl.task.value == e ? Colors.grey.withOpacity(0.2):null                        ),
                          child: Row(
                            children: [
                              Icon(
                                  IconData(e.icon,fontFamily: "MaterialIcons"),
                                  color: HexColor.fromHex(e.color ),
                              ),
                              SizedBox(width: 3.0.wp,),
                              Text("${e.tilte}",
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold
                                ),),

                            ],
                          ),
                        ),
                      ),
                    )
            )
          ],
        ),
      ),
    );
  }
}
