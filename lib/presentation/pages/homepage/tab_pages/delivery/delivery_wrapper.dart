import 'dart:async';

import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
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

  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final riderAuthstate = Provider.of<RiderAuth?>(context);
    return StreamBuilder(
      stream: FirestoreRepo(uid: riderAuthstate!.uid).rider,
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Rider rider = snapshot.data;
          if (rider.workingStatus == 'acceptedOrder') {
            return DeliveryOrderAccepted(rider: rider);
          } else {
            if (rider.isWorking) {
              if (streamSubscription == null) {
                streamCheckOrderAvailable(rider.documentID!);
              }
            } else {
              streamSubscription
                  ?.cancel()
                  .then((_) => streamSubscription = null);
            }

            return DeliveryTab();
          }
        } else {
          return loadingPillriveR(250);
        }
      },
    );
  }

  streamCheckOrderAvailable(String riderId) {
    Stream<Rider?> streamRider = FirestoreRepo(uid: riderId).rider;
    streamSubscription = streamRider.listen((rider) async {
      if (rider != null && rider.workingStatus == 'Pending') {
        streamSubscription?.pause();
        OrderService orderService =
            await FirestoreRepo().getCurrentOrder(rider.currentOrderId!);
        if (!mounted) return;
        if (!await handleOrder(riderId, orderService)) {
          if (streamSubscription!.isPaused) {
            streamSubscription?.resume();
          }
        }
      }
    });
  }

  Future<bool> handleOrder(String riderId, OrderService order) async {
    Navigator.of(context)
        .pushNamed('/orderrequest', arguments: order)
        .then((value) async {
      if (value == true) {
        streamSubscription?.cancel().then((_) => streamSubscription = null);
        await FirestoreRepo(uid: riderId)
            .updateOrderAccepted(order.documentID!);
        await FirestoreRepo(uid: riderId)
            .updateCurrentOrderId(order.documentID!);
        return true;
      } else {
        await FirestoreRepo(uid: riderId)
            .updateOrderRejected([order.documentID!]);
        return false;
      }
    });
    return false;
  }

  Future changeOrderToPending(String orderId) async {
    await FirestoreRepo().updateOrderQueryStatusPendingTransaction(orderId);
  }

  @override
  void dispose() {
    streamSubscription?.cancel().then((_) => streamSubscription = null);
    super.dispose();
  }
}
