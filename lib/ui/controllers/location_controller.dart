import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final _latitud = 11.458621.obs;
  final _longitud = (-7.4111983).obs;
  final _lastActualization = const TimeOfDay(hour: 12, minute: 22).obs;
  final _markerVisibility = false.obs;

  bool get markerVisibility => _markerVisibility.value;
  double get latitud => _latitud.value;
  double get longitud => _longitud.value;
  TimeOfDay get lastActualization => _lastActualization.value;

  setLat(newValue) => _latitud.value = newValue;
  setLon(newValue) => _longitud.value = newValue;
  setLastAct(newValue) => _lastActualization.value = newValue;
  makerVisibility(newValue) => _markerVisibility.value = newValue;
}
