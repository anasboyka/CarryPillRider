import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({Key? key}) : super(key: key);

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  @override
  Widget build(BuildContext context) {
    Rider rider = Provider.of<Rider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kcWhite,
        shadowColor: kcTransparent,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () async {
              await AuthRepo().signOut();
              // Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kcPrimary,
              size: 35,
            )),
      ),
      body: Container(
        color: kcWhite,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padSymR(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete your detail',
                    style: kwtextStyleRD(
                      fs: 30,
                      fw: kfbold,
                    ),
                  ),
                  gaphr(h: 12),
                  dividerC(c: kcborderGrey, t: 10),
                  gaphr(),
                  Text(
                    'Personal',
                    style: kwtextStyleRD(
                      c: kcgrey,
                      fs: 28,
                      fw: kfmedium,
                    ),
                  ),
                  gaphr(h: 32),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: kcTransparent,
                  child: ListTile(
                    title: Text(
                      'Profile Info',
                      style: kwtextStyleRD(
                        fs: 18,
                        fw: kfmedium,
                        c: kcgrey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rider.profile == null ? 'Required' : 'Completed',
                          style: kwtextStyleRD(
                            fs: 14,
                            c: rider.profile == null
                                ? kcRedRequired
                                : kcstatusGreen,
                            fw: kfmedium,
                          ),
                        ),
                        //gapwr(w: 8),
                        const Icon(
                          Icons.chevron_right,
                          size: 32,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/profileinfo', arguments: rider);
                      // print('tap');
                    },
                    contentPadding: padSymR(),
                  ),
                ),
                Padding(
                  padding: padSymR(),
                  child: divider(c: kcborderGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: kcTransparent,
                  child: ListTile(
                    title: Text(
                      'Vehicle Info',
                      style: kwtextStyleRD(
                        fs: 18,
                        fw: kfmedium,
                        c: kcgrey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rider.vehicle == null ? 'Required' : 'Completed',
                          style: kwtextStyleRD(
                            fs: 14,
                            c: rider.vehicle == null
                                ? kcRedRequired
                                : kcstatusGreen,
                            fw: kfmedium,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 32,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/vehicleinfo', arguments: rider);
                    },
                    contentPadding: padSymR(),
                  ),
                ),
                Padding(
                  padding: padSymR(),
                  child: divider(c: kcborderGrey),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: padSymR(),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 64,
                highlightColor: (rider.profile != null && rider.vehicle != null)
                    ? null
                    : Colors.transparent,
                splashColor: (rider.profile != null && rider.vehicle != null)
                    ? null
                    : Colors.transparent,
                color: (rider.profile != null && rider.vehicle != null)
                    ? kcPrimary
                    : kcdisabledBtn,
                highlightElevation: 0,
                elevation:
                    (rider.profile != null && rider.vehicle != null) ? 2 : 0,
                shape: cornerR(r: 12),
                onPressed: (rider.profile != null && rider.vehicle != null)
                    ? () async {
                        await FirestoreRepo(uid: rider.documentID!)
                            .updateRiderProfileComplete(true);
                        //todo complete sign up
                      }
                    : () {},
                child: Text(
                  'Complete Sign Up',
                  style: kwtextStyleRD(
                    fs: 20,
                    fw: kfbold,
                    c: (rider.profile != null && rider.vehicle != null)
                        ? kcWhite
                        : kcgrey,
                  ),
                ),
              ),
            ),
            gaphr(h: 30),
          ],
        ),
      ),
    );
  }
}
