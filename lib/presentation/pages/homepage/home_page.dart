import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/delivery/delivery_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/history_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/map_tab.dart';
import 'package:carrypill_rider/presentation/pages/homepage/tab_pages/profile_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBgHome,
      // appBar: AppBar(
      //   title: const Text('Homepage'),
      // ),
      body: IndexedStack(
        children: [
          DeliveryTab(),
          MapTab(),
          HistoryTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
          color: kcWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconTabButton(0, 'Delivery', Icons.delivery_dining),
            iconTabButton(1, 'Map', Icons.map),
            iconTabButton(2, 'History', Icons.history),
            iconTabButton(3, 'profile', Icons.person_outline),
          ],
        ),
      ),
    );
  }

  Widget iconTabButton(int index, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: MaterialButton(
        minWidth: 75,
        shape: cornerR(r: 50),
        child: Column(
          children: [
            gaphr(h: 13),
            Icon(
              icon,
              color: kcPrimary,
            ),
            gaphr(h: 5),
            Text(
              label, //'Delivery',
              style: kwtextStyleRD(
                c: kcPrimary,
              ),
            )
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
