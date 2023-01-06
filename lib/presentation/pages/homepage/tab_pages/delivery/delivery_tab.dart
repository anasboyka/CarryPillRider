import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_string.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/shift_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DeliveryTab extends StatefulWidget {
  const DeliveryTab({Key? key}) : super(key: key);

  @override
  State<DeliveryTab> createState() => _DeliveryTabState();
}

class _DeliveryTabState extends State<DeliveryTab> {
  //bool isWorking1 = true, autoAccept = false;

  @override
  Widget build(BuildContext context) {
    Rider rider = Provider.of<Rider?>(context)!;
    RiderAuth riderAuth = Provider.of<RiderAuth?>(context)!;
    // print(rider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status',
          style: kwtextStyleRD(
            fw: FontWeight.bold,
            fs: 22,
          ),
        ),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                AuthRepo().signOut();
              });
            },
            icon: const Icon(Icons.logout, color: kcPrimary),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: padSymR(),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
              color: kcWhite,
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: rider.isWorking ? kcstatusGreen : kcdisabledBtn,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    child: Text(
                      rider.isWorking ? 'Working' : 'Not Working',
                      style: kwtextStyleRD(
                        fs: 14,
                        fw: FontWeight.w500,
                        c: rider.isWorking ? kcWhite : kcBlack,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                rider.isWorking
                    ? Text(
                        'Auto accept order',
                        style: kwtextStyleRD(
                          fs: 16,
                          fw: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
                const Spacer(),
                rider.isWorking
                    ? Switch.adaptive(
                        activeColor: kcstatusGreen,
                        value: rider.autoAccept,
                        onChanged: (value) async {
                          await FirestoreRepo(uid: riderAuth.uid)
                              .updateAutoAccept(value);
                          // setState(() {
                          //   autoAccept = value;
                          // });
                        })
                    : const SizedBox()
              ],
            ),
          ),
          ShiftTab(rider: rider)
        ],
      ),
    );
  }
}

// class ShiftTab extends StatelessWidget {
//   const ShiftTab({
//     Key? key,
//     required this.rider,
//     required this.riderAuth,
//   }) : super(key: key);

//   final Rider rider;
//   final RiderAuth riderAuth;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padSymR(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: kcWhite,
//                 borderRadius: borderRadiuscR(r: 8),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: const Offset(0, 2),
//                     blurRadius: 5,
//                     spreadRadius: 1,
//                     color: Colors.black.withOpacity(0.15),
//                   ),
//                 ]),
//             child: Padding(
//               padding: padSymR(v: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Aug 1 - 15, 2022',
//                     style: kwtextStyleRD(
//                       fs: 16,
//                       fw: FontWeight.w500,
//                     ),
//                   ),
//                   gaphr(h: 8),
//                   Text(
//                     '+RM 432.00',
//                     style: kwtextStyleRD(
//                       fs: 16,
//                       fw: FontWeight.bold,
//                       c: kcProfit,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           gaphr(h: 30),
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: kcWhite,
//               borderRadius: borderRadiuscR(r: 8),
//               boxShadow: [
//                 BoxShadow(
//                   offset: const Offset(0, 2),
//                   blurRadius: 5,
//                   spreadRadius: 1,
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: padSymR(
//                 v: 20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: kcBgHome,
//                       borderRadius: borderRadiuscR(r: 8),
//                     ),
//                     child: Padding(
//                       padding: padSymR(v: 8, h: 8),
//                       child: Text(
//                         '04 Aug, Thursday',
//                         style: kwtextStyleRD(fs: 20, fw: FontWeight.w500),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   gaphr(h: 40),
//                   Row(
//                     children: [
//                       Text(
//                         rider.isWorking
//                             ? "Recent profit: "
//                             : "Current profit: ",
//                         style: kwtextStyleRD(
//                           fs: 18,
//                           fw: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                         '+RM 24.00',
//                         style: kwtextStyleRD(
//                             c: kcProfit, fs: 18, fw: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                   gaphr(),
//                   Text(
//                     rider.isWorking
//                         ? 'Recomended work time : 3 hours'
//                         : 'Current working hours: 3 hours',
//                     style: kwtextStyleRD(
//                       fs: 16,
//                       fw: FontWeight.w500,
//                     ),
//                   ),
//                   gaphr(h: rider.isWorking ? 0 : 20),
//                   rider.isWorking
//                       ? const SizedBox()
//                       : const Text(
//                           'are you ready?',
//                           style: kwstyleb16,
//                         ),
//                   gaphr(),
//                   MaterialButton(
//                     minWidth: double.infinity,
//                     height: 64,
//                     color: kcPrimary,
//                     shape: cornerR(
//                       r: 8,
//                     ),
//                     onPressed: () async {
//                       await FirestoreRepo(uid: riderAuth.uid)
//                           .updateWorkingStatus(
//                               !rider.isWorking,
//                               rider.isWorking
//                                   ? ksStopAcceptingOrder
//                                   : ksIsWaitingForOrder);
//                     },
//                     child: Text(
//                       rider.isWorking ? 'End Shift' : 'Start Working Now',
//                       style: kwtextStyleRD(
//                           c: kcWhite, fs: 20, fw: FontWeight.bold),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
