import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  //final String email;
  final double latitude;
  final double longitude;
  final TimeOfDay time;

  UserLocation({/*required this.email,*/ required this.latitude, required this.longitude, required this.time});

  static UserLocation fromPosition(/*String email,*/ Position position, TimeOfDay date) {
    return UserLocation(
        /*email: email,*/ latitude: position.latitude, longitude: position.longitude, time: date);
  }
}
