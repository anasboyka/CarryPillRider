import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:carrypill_rider/data/local/shared_preferences.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/logic/provider/provider_location.dart';
import 'package:carrypill_rider/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'data/datarepositories/map_repo/location_repo.dart';

void main() async {
  //al punya testing branch
  WidgetsFlutterBinding.ensureInitialized();
  await Spreferences.init();

  await Firebase.initializeApp();
  Position? position = await LocationRepo().initPosition();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderLocation>.value(
          value: ProviderLocation(position: position),
        ),
        StreamProvider<RiderAuth?>.value(
            catchError: (_, __) => null,
            value: AuthRepo().rider,
            initialData: null),
      ],
      child: const MyApp(),
    ),
  );
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
                iconTheme: IconThemeData(color: kcPrimary),
              ),
            ),
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
