import 'package:animations/animations.dart';
import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/order_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/shift_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/tabs/status_tab.dart';
import 'package:flutter/material.dart';

class DeliveryOrderAccepted extends StatefulWidget {
  const DeliveryOrderAccepted({Key? key}) : super(key: key);

  @override
  State<DeliveryOrderAccepted> createState() => _DeliveryOrderAcceptedState();
}

class _DeliveryOrderAcceptedState extends State<DeliveryOrderAccepted> {
  int currentIndex = 0;
  List<ValueKey<int>> _keys = [
    ValueKey<int>(0),
    ValueKey<int>(1),
    ValueKey<int>(2)
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            tabs: [
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
          // //key: ValueKey<int>(currentIndex),
          // index: currentIndex,
          children: [
            ShiftTab(
                // key: _keys[0],
                ),
            OrderTab(
                // key: _keys[1],
                ),
            StatusTab(
                // key: _keys[2],
                ),
          ],
        ),
      ),
    );
  }
}
