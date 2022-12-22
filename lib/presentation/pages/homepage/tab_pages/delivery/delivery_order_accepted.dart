import 'package:animations/animations.dart';
import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/patient.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/order_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/shift_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/status_tab_delivery.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/status_tab_pickup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryOrderAccepted extends StatefulWidget {
  Rider rider;

  // OrderService orderService;
  DeliveryOrderAccepted({
    required this.rider,

    // required this.orderService,
    Key? key,
  }) : super(key: key);

  @override
  State<DeliveryOrderAccepted> createState() => _DeliveryOrderAcceptedState();
}

class _DeliveryOrderAcceptedState extends State<DeliveryOrderAccepted> {
  int currentIndex = 2;
  late String orderId;

  @override
  void initState() {
    // TODO: implement initState
    orderId = widget.rider.currentOrderId!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final riderAuthstate = Provider.of<RiderAuth?>(context);
    Rider? rider = Provider.of<Rider?>(context);
    return StreamBuilder(
        stream:
            FirestoreRepo(uid: riderAuthstate!.uid).streamCurrentOrder(orderId),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            OrderService orderService = snapshot.data;
            return FutureBuilder(
                future:
                    FirestoreRepo().getPatientFuture(orderService.patientRef!),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Patient patient = snapshot.data;
                    return DefaultTabController(
                      length: 3,
                      initialIndex: currentIndex,
                      child: Scaffold(
                        appBar: AppBar(
                          elevation: 1,
                          title: Text(
                            'Delivery',
                            style: kwtextStyleRD(
                              fw: FontWeight.bold,
                              fs: 22,
                            ),
                          ),
                          bottom: TabBar(
                            indicatorColor: kcPrimary,
                            labelColor: kcPrimary,
                            unselectedLabelColor: kcBlack2,
                            onTap: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: 'Shift',
                              ),
                              Tab(
                                text: 'Order',
                              ),
                              Tab(
                                text: 'Status',
                              ),
                            ],
                          ),
                        ),
                        body: TabBarView(
                          // index: currentIndex,
                          children: [
                            ShiftTab(
                              rider: widget.rider,
                              // key: _keys[0],
                            ),
                            OrderTab(
                              orderService: orderService,
                              patient: patient,
                              rider: rider!,
                              // key: _keys[1],
                            ),
                            orderService.serviceType ==
                                    ServiceType.requestDelivery
                                ? StatusTabDelivery(
                                    orderService: orderService,
                                    patient: patient,
                                    rider: rider)
                                : StatusTabPickup(
                                    orderService: orderService,
                                    patient: patient,
                                    rider: rider,
                                  )
                            // StatusTabDelivery(
                            //   orderService: orderService,
                            //   patient: patient,
                            //   rider: rider,
                            //   // key: _keys[2],
                            // ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Scaffold(
                      backgroundColor: kcWhite,
                      body: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  }
                });
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        });
  }
}
