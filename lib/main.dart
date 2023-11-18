import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/domain/use_cases/locator_service.dart';
import 'package:proychat/ui/controllers/user_controller.dart';
import 'ui/controllers/location_controller.dart';
import 'ui/my_app.dart';

void main() {
  Get.put(UserController());
  Get.put(LocatorService());
  Get.put(LocationController());
  runApp(const MyApp());
}
