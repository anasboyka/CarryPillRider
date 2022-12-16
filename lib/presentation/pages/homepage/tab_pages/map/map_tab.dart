import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key? key}) : super(key: key);

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBgHome,
      appBar: AppBar(
        title: Text(
          'Map',
          style: kwtextStyleRD(
            fs: 20,
            fw: kfbold,
          ),
        ),
        elevation: 0,
      ),

      // body: GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   initialCameraPosition: CameraPosition(
      //     target: _center,
      //     zoom: 11.0,
      //   ),
      // ),
    );
  }
}
