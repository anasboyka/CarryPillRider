import 'package:carrypill_rider/presentation/pages/authenticate/sign_in.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_up.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/startup.dart';
import 'package:carrypill_rider/presentation/pages/homepage/home_page.dart';
import 'package:carrypill_rider/presentation/pages/homepage/order_request.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/delivery_order_accepted.dart';
import 'package:flutter/material.dart';

class WrapperHome extends StatelessWidget {
  WrapperHome({Key? key}) : super(key: key);
  bool alreadyLogin = true;

  @override
  Widget build(BuildContext context) {
    if (!alreadyLogin) {
      return Startup();
    } else {
      //todo check is admin
      return DeliveryOrderAccepted();
    }
  }
}
