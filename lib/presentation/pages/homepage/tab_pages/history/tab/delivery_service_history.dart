import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DeliveryServiceHistory extends StatefulWidget {
  const DeliveryServiceHistory({Key? key}) : super(key: key);

  @override
  State<DeliveryServiceHistory> createState() => _DeliveryServiceHistoryState();
}

class _DeliveryServiceHistoryState extends State<DeliveryServiceHistory> {
  @override
  Widget build(BuildContext context) {
    Rider? rider = Provider.of<Rider?>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          gaphr(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery History',
                style: kwtextStyleRD(
                  c: kcPrimary,
                  fs: 17,
                  fw: FontWeight.w600,
                ),
              ),
            ),
          ),
          gaphr(),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // gaphr(),
                  StreamBuilder(
                      stream: FirestoreRepo(uid: rider!.documentID!)
                          .streamListOrderDelivery(),
                      builder: ((_, AsyncSnapshot snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          List<OrderService> orderServiceList = snapshot.data;
                          if (orderServiceList.isNotEmpty) {
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: orderServiceList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    orderServiceList[index]
                                        .facility!
                                        .facilityName,
                                    style: kwtextStyleRD(
                                        fw: kfbold, fs: 16, c: kcBlack2),
                                  ),
                                  // 'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}'),
                                  subtitle: Text(DateFormat('dd/MM/yyyy')
                                      .format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}',
                                        style: kwtextStyleRD(
                                          fs: 14,
                                          c: kcProfit,
                                          fw: kfextrabold,
                                        ),
                                      ),
                                      Text(DateFormat('h:mm a').format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return ListTile(
                              title: Text('No order'),
                            );
                          }
                        } else {
                          return loadingPillriveR(100);
                          // const Center(
                          //     child: CircularProgressIndicator.adaptive());
                        }
                      })),
                  //gaphr(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
