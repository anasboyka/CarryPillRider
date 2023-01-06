import 'package:carrypill_rider/data/models/facility.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/main.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/register_info/profile_info.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/register_info/vehicle_info.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_in.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_up.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/order_request.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/profile/profile_update.dart';
import 'package:carrypill_rider/presentation/pages/wrapper_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) => WrapperHome());
      case '/signup':
        return CupertinoPageRoute(builder: (_) => SignUp());
      case '/signin':
        return CupertinoPageRoute(builder: (_) => SignIn());
      case '/orderrequest':
        return CupertinoPageRoute(
            builder: (_) => OrderRequest(
                  orderService: args as OrderService,
                ));
      case '/profileinfo':
        return CupertinoPageRoute(
            builder: (_) => ProfileInfo(
                  rider: args as Rider,
                ));
      case '/vehicleinfo':
        return CupertinoPageRoute(
            builder: (_) => VehicleInfo(rider: args as Rider));
      case '/profileupdate':
        return CupertinoPageRoute(
            builder: (_) => ProfileUpdate(rider: args as Rider));
      default:
        return CupertinoPageRoute(builder: (_) => WrapperHome());
    }
  }
}
