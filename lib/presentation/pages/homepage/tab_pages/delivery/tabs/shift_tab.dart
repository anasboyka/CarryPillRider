import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_string.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShiftTab extends StatelessWidget {
  final Rider rider;
  const ShiftTab({
    required this.rider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riderAuthstate = Provider.of<RiderAuth?>(context);
    return Padding(
      padding: padSymR(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gaphr(h: 44),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: borderRadiuscR(r: 8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ]),
            child: Padding(
              padding: padSymR(v: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Earning', //'Aug 1 - 15, 2022',
                    style: kwtextStyleRD(
                      fs: 16,
                      fw: FontWeight.w500,
                    ),
                  ),
                  gaphr(h: 8),
                  Text(
                    'RM ${rider.earning!.toStringAsFixed(2)}', //'+RM 432.00',
                    style: kwtextStyleRD(
                      fs: 16,
                      fw: FontWeight.bold,
                      c: kcProfit,
                    ),
                  )
                ],
              ),
            ),
          ),
          gaphr(h: 30),
          FutureBuilder(
              future: FirestoreRepo(uid: riderAuthstate!.uid).getLatestOrder(),
              builder: (_, AsyncSnapshot snapshot) {
                // print(snapshot);
                if (snapshot.hasData) {
                  OrderService orderService = snapshot.data;
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kcWhite,
                      borderRadius: borderRadiuscR(r: 8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: padSymR(
                        v: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kcBgHome,
                              borderRadius: borderRadiuscR(r: 8),
                            ),
                            child: Padding(
                              padding: padSymR(v: 8, h: 8),
                              child: Text(
                                //todo date
                                dateformatTextShortMonthDay(
                                    DateTime.now()), //'04 Aug, Thursday',
                                style:
                                    kwtextStyleRD(fs: 20, fw: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          gaphr(h: 40),
                          Row(
                            children: [
                              Text(
                                "Recent profit: ",
                                style: kwtextStyleRD(
                                  fs: 18,
                                  fw: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '+RM ${orderService.totalPay.toStringAsFixed(2)}', //'+RM 24.00',
                                style: kwtextStyleRD(
                                    c: kcProfit, fs: 18, fw: FontWeight.bold),
                              )
                            ],
                          ),
                          gaphr(),
                          Text(
                            'Recomended work time : 3 hours',
                            style: kwtextStyleRD(
                              fs: 16,
                              fw: FontWeight.w500,
                            ),
                          ),
                          gaphr(h: rider.isWorking ? 0 : 20),
                          rider.isWorking
                              ? const SizedBox()
                              : const Text(
                                  'are you ready?',
                                  style: kwstyleb16,
                                ),
                          gaphr(),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 64,
                            color: kcPrimary,
                            shape: cornerR(
                              r: 8,
                            ),
                            onPressed: () async {
                              await FirestoreRepo(uid: riderAuthstate.uid)
                                  .updateWorkingStatus(
                                      !rider.isWorking,
                                      rider.isWorking
                                          ? ksStopAcceptingOrder
                                          : ksIsWaitingForOrder);
                            },
                            child: Text(
                              rider.isWorking
                                  ? 'End Shift'
                                  : 'Start Working Now',
                              style: kwtextStyleRD(
                                  c: kcWhite, fs: 20, fw: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                        color: kcWhite,
                        width: double.infinity,
                        height: 100, //MediaQuery.of(context).size.height,
                        child: Center(
                          child: loadingPillr(
                            100,
                          ),
                        ) //CircularProgressIndicator.adaptive(),
                        ),
                  );
                }
              })
        ],
      ),
    );
  }
}
