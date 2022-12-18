import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepo {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  Future<Position?> initPosition() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return null;
    }
    if (hasPermission is bool && hasPermission == false) {
      return null;
    }
    Position? position = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);
    if (position != null) {
      return position;
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    return position;
  }

  Future getCurrentLocation() async {
    final hasPermission = await _handlePermission();
    if (hasPermission is String) {
      return hasPermission;
    }
    if (!hasPermission) {
      return null;
    }
    return await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);
  }

  double calculateDistanceInKm(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
    //return in KM
  }

  double calculateDeliveryCharge(GeoPoint geoPoint1, GeoPoint geoPoint2) {
    double charge = 10 +
        calculateDistanceInKm(geoPoint1.latitude, geoPoint1.longitude,
                geoPoint2.latitude, geoPoint2.longitude)
            .roundToDouble();
    return charge;
  }

  double calculatePickupCharge() {
    double charge = 10;
    return charge;
  }

  Future<dynamic> _handlePermission() async {
    bool serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Please enable your location";
    }

    // if (Platform.isAndroid) {
    LocationPermission permission = await geolocatorPlatform.checkPermission();
    // print('checkpermission');
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance
          .requestPermission(); //await LocationProvider().requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return "Please give access to location permission";
      } else {
        return true;
      }
    }
    //}

    return true;
  }
}
