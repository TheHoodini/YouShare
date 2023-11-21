import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/data/model/user_location.dart';
import 'package:proychat/domain/use_cases/locator_service.dart';

class LocationController extends GetxController {
  LocatorService service = Get.find();

  //variables y funciones del controlador
  var userLocation = UserLocation(latitude: 0, longitude: 0, time: const TimeOfDay(hour: 0, minute: 0)).obs;
  final _lastActualization = const TimeOfDay(hour: 12, minute: 22).obs;
  final _markerVisibility = false.obs;

  bool get markerVisibility => _markerVisibility.value;
  TimeOfDay get lastActualization => _lastActualization.value;

  setLastAct(newValue) => _lastActualization.value = newValue;
  makerVisibility(newValue) => _markerVisibility.value = newValue;

  //variables y funciones externas
  Future<void> getLocation() async {
    userLocation.value =
        await service.getLocation().onError((error, stackTrace) {
      return Future.error(error.toString());
    });
  }

  Future<void> subscribeLocationUpdate() async {}

  Future<void> unsubscribeLocationUpdate() async {}
}
