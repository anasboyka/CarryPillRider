import 'dart:async';

import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/delivery_order_accepted.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/delivery_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryWrapper extends StatefulWidget {
  DeliveryWrapper({Key? key}) : super(key: key);

  @override
  State<DeliveryWrapper> createState() => _DeliveryWrapperState();
}

class _DeliveryWrapperState extends State<DeliveryWrapper> {
  bool orderAccepted = true;

  //StreamController streamCon = StreamController();
  StreamSubscription? streamSubscription;
  // OrderService? orderService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final riderAuthstate = Provider.of<RiderAuth?>(context);
    return StreamBuilder(
      stream: FirestoreRepo(uid: riderAuthstate!.uid).rider,
      builder: (_, AsyncSnapshot snapshot) {
        print('build');
        if (snapshot.hasData) {
          Rider rider = snapshot.data;
          if (rider.workingStatus == 'acceptedOrder') {
            return DeliveryOrderAccepted(rider: rider);
          } else {
            //TODO progress
            if (rider.isWorking) {
              print(streamSubscription == null);
              if (streamSubscription == null) {
                streamCheckOrderAvailable(rider.documentID!);
              }
              // startStream(riderAuthstate.uid);
              // print(orderService);
              print(streamSubscription == null);
              print('herrrrrrrr');
            } else {
              streamSubscription
                  ?.cancel()
                  .then((_) => streamSubscription = null);
            }

            return DeliveryTab();

            // return StreamBuilder(
            //     stream: FirestoreRepo(uid: riderAuthstate.uid)
            //         .streamListOrderAvailable(),
            //     builder: (_, AsyncSnapshot snapshot) {
            //       if (snapshot.hasData) {
            //         print('hasdata');
            //         List<OrderService> ordersAvailable = snapshot.data;
            //         OrderService orderService = ordersAvailable[0];
            //         // WidgetsBinding.instance.addPostFrameCallback((_) =>
            //         //     Navigator.of(context).pushNamed('/orderRequest'));

            //         return DeliveryTab();
            //       } else {
            //         print('loading');
            //         return CircularProgressIndicator.adaptive();
            //       }
            //     });
          }

          // Navigator.of(context)
          //     .pushNamed('/orderrequest')
          //     .then((value) => null);

          // if (orderAccepted) {
          //   return DeliveryOrderAccepted();
          // } else {
          //   //return delivery tab
          //   return DeliveryTab();
          // }
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
    // if (orderAccepted) {
    //   return DeliveryOrderAccepted();
    // } else {
    //   return DeliveryTab();
    // }
  }

  streamCheckOrderAvailable(String riderId) {
    Stream<Rider?> streamRider = FirestoreRepo(uid: riderId).rider;
    streamSubscription = streamRider.listen((rider) async {
      if (rider != null && rider.workingStatus == 'Pending') {
        streamSubscription?.pause();
        OrderService orderService =
            await FirestoreRepo().getCurrentOrder(rider.currentOrderId!);
        if (!mounted) return;
        if (await handleOrder(riderId, orderService)) {
          await FirestoreRepo().updateOrderAccepted(rider.currentOrderId!);
          await Future.delayed(const Duration(seconds: 2));
          await FirestoreRepo().updateStatusOrder(
              StatusOrder.driverToHospital, rider.currentOrderId!);
          streamSubscription?.cancel().then((_) => streamSubscription = null);
        } else {
          if (streamSubscription!.isPaused) {
            streamSubscription?.resume();
          }
          //todo reject order list
        }
      }
    });
  }

  // startStream(String riderId) {
  //   Stream<List<OrderService>?> stream =
  //       FirestoreRepo(uid: riderId).streamListOrderAvailable();
  //   streamSubscription = stream.listen((event) async {
  //     if (event != null && event.isNotEmpty) {
  //       print(event);
  //       // print(event[0]);
  //       for (var i = 0; i < event.length; i++) {
  //         OrderService order = event[i];
  //         if (order.riderCancelId != null && order.riderCancelId!.isNotEmpty) {
  //           if (!order.riderCancelId!.contains(riderId)) {
  //             print('heree');
  //             print(order.documentID!);
  //             await changeOrderToPending(order.documentID!);
  //             if (!mounted) return;
  //             if (await handleOrder(riderId, order)) {
  //               await FirestoreRepo().updateStatusOrder(
  //                   StatusOrder.driverToHospital, order.documentID!);
  //               break;
  //             }
  //             // Navigator.of(context)
  //             //     .pushNamed('/orderrequest')
  //             //     .then((value) async {
  //             //   if (value == true) {
  //             //     streamSubscription?.cancel();
  //             //     await FirestoreRepo(uid: riderId)
  //             //         .updateOrderAccepted(order.documentID!);
  //             //     await FirestoreRepo(uid: riderId)
  //             //         .updateCurrentCustomerId(order.patientRef!);
  //             //   } else {
  //             //     await FirestoreRepo()
  //             //         .updateOrderRejected([riderId], order.documentID!);
  //             //   }
  //             // });
  //           }
  //         } else {
  //           await changeOrderToPending(order.documentID!);
  //           if (!mounted) return;
  //           if (await handleOrder(riderId, order)) {
  //             break;
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  Future<bool> handleOrder(String riderId, OrderService order) async {
    print('push');
    Navigator.of(context).pushNamed('/orderrequest').then((value) async {
      if (value == true) {
        streamSubscription?.cancel().then((_) => streamSubscription = null);
        await FirestoreRepo(uid: riderId)
            .updateOrderAccepted(order.documentID!);
        await FirestoreRepo(uid: riderId)
            .updateCurrentOrderId(order.documentID!);
        return true;
      } else {
        await FirestoreRepo(uid: riderId).updateOrderRejected([riderId]);
        return false;
      }
    });
    return false;
  }

  Future changeOrderToPending(String orderId) async {
    await FirestoreRepo().updateOrderQueryStatusPendingTransaction(orderId);
  }

  // Future updateOrderAccepted(String orderId) async {
  //   await FirestoreRepo().updateOrderQueryStatus('Accepted', orderId);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription?.cancel().then((_) => streamSubscription = null);
    super.dispose();
  }
}
