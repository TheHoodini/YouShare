import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/config/config.dart';
import 'package:proychat/domain/use_cases/locator_service.dart';
import 'package:proychat/ui/controllers/authentication_controller.dart';
import 'package:proychat/ui/controllers/chatController.dart';
import 'package:proychat/ui/controllers/user_controller.dart';
import 'ui/controllers/location_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ui/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: Configuration.apiKey,
    authDomain: Configuration.authDomain,
    databaseURL: Configuration.databaseURL,
    projectId: Configuration.projectId,
    // storageBucket: Configuration.storageBucket,
    messagingSenderId: Configuration.messagingSenderId,
    appId: Configuration.appId,
    // measurementId: Configuration.measurementId),
  ));

  Get.put(ChatController());
  Get.put(AuthenticationController());
  Get.put(UserController());
  Get.put(LocatorService());
  Get.put(LocationController());

  runApp(const MyApp());
}
