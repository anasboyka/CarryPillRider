import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.black,
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CarryPill Rider',
            theme: ThemeData(
                primarySwatch: kcprimarySwatch,
                appBarTheme: const AppBarTheme(
                  backgroundColor: kcWhite,
                  elevation: 3,
                )),
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
