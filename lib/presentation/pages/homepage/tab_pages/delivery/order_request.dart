import 'dart:async';
import 'dart:io';

import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderRequest extends StatefulWidget {
  final OrderService orderService;
  const OrderRequest({Key? key, required this.orderService}) : super(key: key);

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  int durationToAccept = 60;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller, LatLng latLng) {
    mapController = controller;
    controller.moveCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcWhite,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Order',
              style: kwtextStyleRD(
                fs: 20,
                fw: FontWeight.bold,
              ),
            ),
            gaph(h: 5),
            Text(
              widget.orderService.serviceType == ServiceType.requestDelivery
                  ? 'Delivery'
                  : 'Pickup',
              style: kwstyleb14,
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future:
              FirestoreRepo().getPatientFuture(widget.orderService.patientRef!),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Patient patient = snapshot.data;
              return Column(
                children: [
                  gaphr(h: 30),
                  Padding(
                    padding: padSymR(),
                    child: Container(
                      height: 268.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: borderRadiuscR(r: 14),
                        border: Border.all(color: kcborderGrey),
                        color: kcborderGrey,
                      ),
                      child: ClipRRect(
                        borderRadius: borderRadiuscR(r: 14),
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            _onMapCreated(
                                controller,
                                LatLng(patient.geoPoint!.latitude,
                                    patient.geoPoint!.longitude));
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(patient.geoPoint!.latitude,
                                patient.geoPoint!.longitude),
                            zoom: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  gaphr(h: 22),
                  Padding(
                    padding: padSymR(),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delivery Details',
                        style: kwstyleb14,
                      ),
                    ),
                  ),
                  gaphr(),
                  Expanded(
                    child: Padding(
                      padding: padSymR(),
                      child: ListView(
                        //shrinkWrap: true,
                        children: [
                          deliveryDetailDesign(
                            const Icon(
                              Icons.domain,
                            ),
                            "Pickup",
                            3.423,
                            6,
                            widget.orderService.facility!.facilityName,
                            //'Hospital Sultan Abdul Halim',
                            widget.orderService.facility!.fullAddress,
                            //'Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah',
                            true,
                          ),
                          gaphr(h: 4),
                          // FutureBuilder(
                          //     future: FirestoreRepo()
                          //         .getPatientFuture(widget.orderService.patientRef!),
                          //     builder: (_, AsyncSnapshot snapshot) {
                          //       if (snapshot.hasData) {
                          //         Patient patient = snapshot.data;
                          //         return
                          deliveryDetailDesign(
                            const Icon(Icons.pin_drop),
                            "Drop-off",
                            5.87,
                            12,
                            patient.name, //"Iqbal Fakhri Bin Iylia",
                            patient
                                .address!, //"Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah",
                            false,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Platform.isAndroid ? 100 : 120.h,
                    width: double.infinity,
                    child: Column(
                      children: [
                        divider(c: kcborderGrey, t: 1),
                        gaphr(h: Platform.isAndroid ? 15 : 20),
                        Padding(
                          padding: padSymR(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'You will earn',
                                      style: kwstyleb16,
                                    ),
                                    gaph(h: 7),
                                    Text(
                                      'RM ${widget.orderService.totalPay.toStringAsFixed(2)}',
                                      //'RM 12.00',
                                      style: kwtextStyleRD(
                                        c: kcProfit,
                                        fs: 30,
                                        fw: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  shape: cornerR(
                                    r: 8,
                                  ),
                                  minWidth: double.infinity,
                                  height: 64,
                                  color: kcPrimary,
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    'Accept',
                                    style: kwstyleBtn20b,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return loadingPillriveR(
                  250); //CircularProgressIndicator.adaptive();
            }
          }),
    );
  }

  Widget deliveryDetailDesign(Icon icon, String title, double distance,
      int duration, String subtitleName, String address, bool stepper) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              icon,
              gaphr(h: 8),
              stepper
                  ? Expanded(
                      child: Container(
                        color: kcdisabledBtn,
                        width: 3,
                      ),
                    )
                  : const SizedBox(),
              gaphr(h: 4.5)
            ],
          ),
          gapwr(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title, //'Pickup',
                      style: kwtextStyleRD(fs: 16, fw: FontWeight.bold),
                    ),
                    //TODO distance duration kalau sempat
                    // Text(
                    //   '${distance.toStringAsFixed(1)}km ~ ${duration}min',
                    //   style: kwtextStyleRD(fs: 16, fw: FontWeight.bold),
                    // ),
                  ],
                ),
                gaphr(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subtitleName, //'Hospital Sultan Abdul Halim',
                    style: kwtextStyleRD(
                      fs: 16,
                    ),
                  ),
                ),
                gaphr(h: 5),
                Text(
                  address, // 'Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah',
                  style: kwstyleb12,
                ),
                gaphr(h: 18),
              ],
            ),
          )
        ],
      ),
    );
  }
}
