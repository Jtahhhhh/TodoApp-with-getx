import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_course/app/data/services/storage/services.dart';
import 'package:getx_course/app/modules/home/home_binding.dart';
import 'package:getx_course/app/modules/home/home_view.dart';

void main()  async {
  await GetStorage.init();
  await Get.putAsync(()=> StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  // Changed from MaterialApp to GetMaterialApp
      title: 'ToDo List using getx',
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
