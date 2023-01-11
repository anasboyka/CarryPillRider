import 'dart:math';

import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/models/all_enum.dart';
import 'package:carrypill_rider/data/models/order_service.dart';
import 'package:carrypill_rider/data/models/patient.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/rider_uid.dart';
import 'package:carrypill_rider/presentation/custom_widgets/paint/timeline_paint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

class StatusTabDelivery extends StatefulWidget {
  OrderService orderService;
  Patient patient;
  Rider rider;

  StatusTabDelivery({
    Key? key,
    required this.orderService,
    required this.patient,
    required this.rider,
  }) : super(key: key);

  @override
  State<StatusTabDelivery> createState() => _StatusTabDeliveryState();
}

class _StatusTabDeliveryState extends State<StatusTabDelivery>
    with AutomaticKeepAliveClientMixin<StatusTabDelivery> {
  int currentStep = 0;
  final List<Map<String, dynamic>> _processes = [
    {
      "title": 'Fill in form',
      "instruction":
          'Fill in all of the patient information in the required form'
    },
    {
      "title": 'Submit form',
      "instruction":
          'Queue and submit the form to the counter and wait for the token number'
    },
    {
      "title": 'Receive item',
      "instruction":
          'Wait for the medicine to be prepared and proceed with the delivery'
    },
  ];

  int currentStepRegister = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return kcPrimary2;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  int _processIndex = 0;

  @override
  Widget build(BuildContext context) {
    final riderAuthstate = Provider.of<RiderAuth?>(context);
    Rider? rider = Provider.of<Rider>(context);
    OrderService orderService = widget.orderService;
    Patient patient = widget.patient;
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stepper(
          // onStepContinue: () {
          //   setState(() {
          //     currentStep = currentStep + 1;
          //   });
          // },
          type: StepperType.vertical,
          currentStep: currentStep,
          controlsBuilder: (context, details) {
            if (details.currentStep == 0) {
              return MaterialButton(
                minWidth: double.infinity,
                height: 46,
                color: kcPrimary,
                shape: cornerR(r: 8),
                onPressed: () async {
                  await FirestoreRepo().updateStatusOrder(
                      StatusOrder.driverQueue, widget.orderService.documentID!);
                  setState(() {
                    currentStep = currentStep + 1;
                  });
                  //details.onStepContinue;
                },
                child: Text(
                  "Arrive at the healthcare facility",
                  style: kwtextStyleRD(
                    c: kcWhite,
                    fs: 15,
                    fw: FontWeight.bold,
                  ),
                ),
              );
            } else if (details.currentStep == 1) {
              return MaterialButton(
                minWidth: double.infinity,
                height: 46,
                color: _processIndex >= _processes.length
                    ? kcPrimary
                    : kcdisabledBtn,
                elevation: _processIndex >= _processes.length ? null : 0,
                highlightElevation: 0,
                highlightColor: _processIndex >= _processes.length
                    ? null
                    : Colors.transparent,
                splashColor: _processIndex >= _processes.length
                    ? null
                    : Colors.transparent,

                shape: cornerR(r: 8),
                onPressed: () async {
                  if (_processIndex >= _processes.length) {
                    await FirestoreRepo().updateStatusOrder(
                        StatusOrder.outForDelivery,
                        widget.orderService.documentID!);
                    setState(() {
                      currentStep = currentStep + 1;
                    });
                  }
                }, //details.onStepContinue,
                child: Text(
                  "Out for delivery",
                  style: kwtextStyleRD(
                    c: _processIndex >= _processes.length ? kcWhite : kcgrey,
                    fs: 15,
                    fw: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return MaterialButton(
                minWidth: double.infinity,
                height: 46,
                color: kcPrimary,
                shape: cornerR(r: 8),
                onPressed: () async {
                  await FirestoreRepo(uid: riderAuthstate!.uid)
                      .updateOrderComplete(
                    widget.orderService.documentID!,
                    DateTime.now(),
                    rider.isWorking,
                  );
                  await FirestoreRepo(uid: riderAuthstate.uid)
                      .updateEarning(widget.orderService.totalPay);
                  // await FirestoreRepo().updateStatusOrder(
                  //     StatusOrder.orderArrived, widget.orderService.documentID!);
                  // await FirestoreRepo(uid: widget.orderService.riderRef)
                  //     .updateCurrentOrderId(null);
                },
                child: Text(
                  "Drop-off",
                  style: kwtextStyleRD(
                    c: kcWhite,
                    fs: 15,
                    fw: FontWeight.bold,
                  ),
                ),
              );
            }
          },
          steps: [
            Step(
              title: Text(
                'Go to the healthcare facility',
                style: kwtextStyleRD(c: kcPrimary, fs: 16, fw: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderService.facility!
                          .facilityName, //'Hospital Sultan Abdul Halim',
                      style: kwtextStyleRD(
                          fs: 16, fw: FontWeight.w500, c: kcBlack2),
                    ),
                    gaph(h: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            orderService.facility!
                                .fullAddress, //'Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah',
                            style: kwtextStyleRD(
                              fs: 12,
                              fw: kfregular,
                              c: kcgreyaddress,
                            ),
                          ),
                        ),
                        IconButton(
                            iconSize: 25,
                            splashRadius: 25,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                maxHeight: 25, maxWidth: 25),
                            alignment: Alignment.center,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.location_on,
                              size: 20,
                              color: kcPrimary,
                            ))
                      ],
                    ),
                    gaph()
                  ],
                ),
              ),
            ),
            Step(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Register Patient',
                      style: kwtextStyleRD(
                          c: kcPrimary, fs: 16, fw: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        //todo step to register
                      },
                      child: Text(
                        'Step to register',
                        style: kwtextStyleRD(
                          c: kcRequestPickupDescrp,
                          fs: 12,
                          fw: kfregular,
                        ),
                      ))
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: LayoutBuilder(builder: (context, constraint) {
                      return Timeline.tileBuilder(
                        theme: TimelineThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: const ConnectorThemeData(
                            space: 10.0,
                            thickness: 3.0,
                          ),
                        ),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.before,
                          itemExtentBuilder: (_, __) =>
                              constraint.maxWidth / _processes.length,
                          //MediaQuery.of(context).size.width / _processes.length,
                          // oppositeContentsBuilder: (context, index) {
                          //   return Padding(
                          //     padding: const EdgeInsets.only(bottom: 15.0),
                          //     child: ,
                          //   );
                          // },
                          contentsBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                _processes[index]['title']!,
                                style: kwtextStyleRD(
                                  c: kcGreyLabel2,
                                  fs: 12,
                                  fw: kfbold,
                                ),
                              ),
                            );
                          },
                          indicatorBuilder: (_, index) {
                            var color;
                            var child;
                            if (index == _processIndex) {
                              color = kcPrimary2;
                              child = const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                            } else if (index < _processIndex) {
                              color = kcPrimary;
                              child = const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15.0,
                              );
                            } else {
                              color = todoColor;
                            }
                            if (_processIndex >= _processes.length) {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(20.0, 20.0),
                                    painter: BezierPainter(
                                      color: color,
                                      drawStart: index > 0,
                                      drawEnd: false,
                                    ),
                                  ),
                                  DotIndicator(
                                    size: 20.0,
                                    color: color,
                                    child: child,
                                  ),
                                ],
                              );
                            }

                            if (index <= _processIndex) {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: const Size(20.0, 20.0),
                                    painter: BezierPainter(
                                      color: color,
                                      drawStart: index > 0,
                                      drawEnd: index < _processIndex,
                                    ),
                                  ),
                                  DotIndicator(
                                    size: 20.0,
                                    color: color,
                                    child: child,
                                  ),
                                ],
                              );
                            } else {
                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: Size(15.0, 15.0),
                                    painter: BezierPainter(
                                      color: color,
                                      drawEnd: index < _processes.length - 1,
                                    ),
                                  ),
                                  OutlinedDotIndicator(
                                    borderWidth: 4.0,
                                    color: color,
                                  ),
                                ],
                              );
                            }
                          },
                          connectorBuilder: (_, index, type) {
                            if (index > 0) {
                              if (index == _processIndex) {
                                final prevColor = getColor(index - 1);
                                final color = getColor(index);
                                List<Color> gradientColors;
                                if (type == ConnectorType.start) {
                                  gradientColors = [
                                    Color.lerp(prevColor, color, 0.5)!,
                                    color
                                  ];
                                } else {
                                  gradientColors = [
                                    prevColor,
                                    Color.lerp(prevColor, color, 0.5)!
                                  ];
                                }
                                return DecoratedLineConnector(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: gradientColors,
                                    ),
                                  ),
                                );
                              } else {
                                return SolidLineConnector(
                                  color: getColor(index),
                                );
                              }
                            } else {
                              return null;
                            }
                          },
                          itemCount: _processes.length,
                        ),
                      );
                    }),
                  ),
                  gaphr(),
                  Text(
                    _processIndex < _processes.length
                        ? _processes[_processIndex]['instruction']
                        : _processes[_processes.length - 1][
                            'instruction'], //'Fill in all of the patient information in the required form',
                    style: kwtextStyleRD(
                      fs: 12,
                      fw: kfregular,
                      c: kcgreyaddress,
                    ),
                  ),
                  gaphr(h: 10),
                  //debug remove +1
                  _processIndex >= _processes.length //+1
                      ? gaph(h: 0)
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, //padSymR(h: 15, v: 7),
                            backgroundColor: kcPrimary,
                            minimumSize: const Size(104, 30),
                          ),
                          onPressed: () async {
                            // print(_processIndex);
                            if (_processIndex == 1) {
                              await FirestoreRepo().updateStatusOrder(
                                  StatusOrder.orderPreparing,
                                  widget.orderService.documentID!);
                            }
                            setState(() {
                              if (_processIndex != _processes.length) {
                                _processIndex = (_processIndex + 1);
                              } else {
                                _processIndex = 0;
                              }
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Next Step',
                                style: kwtextStyleRD(
                                  c: kcWhite,
                                  fs: 11,
                                  fw: kfbold,
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                              ),
                            ],
                          ),
                          // child: Text(
                          //   'Next Step',
                          //   style: kwtextStyleRD(
                          //     c: kcWhite,
                          //     fs: 11,
                          //     fw: kfbold,
                          //   ),
                          // ),
                        )
                ],
              ),
            ),
            Step(
              title: Text(
                'Delivery',
                style: kwtextStyleRD(c: kcPrimary, fs: 16, fw: FontWeight.bold),
              ),
              content: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      //'Iqbal Fakhri Bin Iylia',
                      style: kwtextStyleRD(
                          fs: 16, fw: FontWeight.w500, c: kcBlack2),
                    ),
                    gaph(h: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            patient
                                .address!, //'MAXIM CITY LIGHTS Building, JALAN SENTUL PASAR Section TAMAN PELANGI, 51100 KUALA LUMPUR WILAYAH PERSEKUTUAN',
                            style: kwtextStyleRD(
                              fs: 12,
                              fw: kfregular,
                              c: kcgreyaddress,
                            ),
                          ),
                        ),
                        IconButton(
                            iconSize: 25,
                            splashRadius: 25,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                maxHeight: 25, maxWidth: 25),
                            alignment: Alignment.center,
                            onPressed: () async {
                              //TODO display map
                              // await FirestoreRepo(uid: riderAuthstate!.uid)
                              //     .updateOrderComplete(
                              //         widget.orderService.documentID!,
                              //         DateTime.now(),rider.isWorking);
                            },
                            icon: const Icon(
                              Icons.location_on,
                              size: 20,
                              color: kcPrimary,
                            ))
                      ],
                    ),
                    gaph()
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
