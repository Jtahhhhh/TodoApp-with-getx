import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_course/app/core/utils/extentions.dart';
import 'package:getx_course/app/data/model/taskModel.dart';
import 'package:getx_course/app/modules/home/home_controller.dart';

import '../../../core/values/colors.dart';
import '../../../widget/icon.dart';

class AddCard extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();
  AddCard({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squarewWidth=Get.width -12.0.wp;
    return Container(
      height: squarewWidth/2,
      width: squarewWidth/2,
      margin: EdgeInsets.symmetric(horizontal:  3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCrtl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.wp, vertical: 4.0.wp),
                    child: TextFormField(
                      controller: homeCrtl.editController,
                      decoration:  const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title'
                      ) ,
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return "Please enter your text";
                        }
                      },
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 2.0.wp,
                    children: icons.map((e)=>Obx(
                        (){
                          final index = icons.indexOf(e);
                          return ChoiceChip(
                              selectedColor: Colors.grey,
                              pressElevation: 0,
                              backgroundColor: Colors.white,
                              label: e,
                              selected: homeCrtl.chipIndex.value == index,
                              onSelected: (bool selected){
                                homeCrtl.chipIndex.value = selected
                                    ? index
                                    : 0;
                              },
                          );
                        }
                    )).toList(),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //primary: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        )
                      ),
                      onPressed: (){
                        if(homeCrtl.formKey.currentState!.validate()){
                          int icon = icons[homeCrtl.chipIndex.value].icon!.codePoint;
                          String color =  icons[homeCrtl.chipIndex.value].color!.toHex();
                          var task = TaskModel(
                              tilte: homeCrtl.editController.text,
                              icon: icon,
                              color: color,

                          );
                          print(task);
                          Get.back();
                          homeCrtl.addTask(task)
                              ?EasyLoading.showSuccess('Create success')
                              :EasyLoading.showError('Duplicated');
                        }
                      },
                      child: Text("Confirm"))
                ],
              ),
            )
          );
          homeCrtl.editController.clear();
          homeCrtl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8,4],
          child: Center(
            child: Icon(Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
