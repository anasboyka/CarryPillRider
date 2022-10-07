import 'package:carrypill_rider/main.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_in.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_up.dart';
import 'package:carrypill_rider/presentation/pages/wrapper_home.dart';
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
      default:
        return CupertinoPageRoute(builder: (_) => WrapperHome());
    }
  }
}
