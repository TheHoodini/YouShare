import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/user_controller.dart';
import 'ui/my_app.dart';

void main() {
  Get.put(UserController());
  runApp(const MyApp());
}
