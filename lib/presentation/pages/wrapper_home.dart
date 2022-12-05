import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/register_info/profile_info.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/register_info/register_info.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/register_info/vehicle_info.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_in.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/sign_up.dart';
import 'package:carrypill_rider/presentation/pages/authenticate/startup.dart';
import 'package:carrypill_rider/presentation/pages/homepage/home_page.dart';
import 'package:carrypill_rider/presentation/pages/homepage/order_request.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/delivery_order_accepted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperHome extends StatelessWidget {
  WrapperHome({Key? key}) : super(key: key);
  //bool alreadyLogin = false;

  @override
  Widget build(BuildContext context) {
    //AuthRepo().signOut();
    final riderAuthstate = Provider.of<RiderAuth?>(context);

    if (riderAuthstate != null) {
      // print(riderAuthstate.uid);
      return StreamBuilder(
          stream: FirestoreRepo(uid: riderAuthstate.uid).rider,
          builder: (_, AsyncSnapshot snapshot) {
            // print(snapshot);
            if (snapshot.hasData) {
              Rider rider = snapshot.data;
              bool isProfileComplete = rider.isProfileComplete ?? false;
              if (isProfileComplete) {
                return StreamProvider<Rider?>.value(
                  initialData: rider,
                  value: FirestoreRepo(uid: riderAuthstate.uid).rider,
                  child: HomePage(),
                );
              } else {
                //TODO complete profile page
                return StreamProvider<Rider?>.value(
                  initialData: rider,
                  value: FirestoreRepo(uid: riderAuthstate.uid).rider,
                  child: RegisterInfo(),
                );
                //return ProfileInfo();
                //return VehicleInfo();
              }
            } else {
              // print('here');
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          });
    } else {
      //todo check is admin
      return SignUp();
    }
  }
}
