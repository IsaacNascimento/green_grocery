import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/routes/app_pages.dart';

void main() {
  Get.lazyPut(() => AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
