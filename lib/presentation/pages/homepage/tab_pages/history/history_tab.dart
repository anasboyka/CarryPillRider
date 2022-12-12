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

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    Rider? rider = Provider.of<Rider?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Service History',
          style: kwtextStyleRD(
            fs: 20,
            fw: kfbold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                          .streamListOrder(),
                      builder: ((_, AsyncSnapshot snapshot) {
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
                                    orderServiceList[index].serviceType ==
                                            ServiceType.requestDelivery
                                        ? 'Delivery'
                                        : 'Pickup',
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
                                      Text(DateFormat('h:mm a').format(
                                          orderServiceList[index].orderDate ??
                                              DateTime.now())),
                                      Text(
                                          'RM ${orderServiceList[index].totalPay.toStringAsFixed(2)}'),
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
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }
                      })),
                  //gaphr(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
