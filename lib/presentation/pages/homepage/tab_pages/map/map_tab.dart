import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/logic/provider/provider_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key? key}) : super(key: key);

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(3.2077, 101.6899);

  // static const CameraPosition _defaultLocation =
  //     CameraPosition(target: LatLng(3.2077, 101.6899), zoom: 20);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final position = Provider.of<ProviderLocation>(context).position!;
    return Scaffold(
      backgroundColor: kcBgHome,
      // appBar: AppBar(
      //   title: Text(
      //     'Map',
      //     style: kwtextStyleRD(
      //       fs: 20,
      //       fw: kfbold,
      //     ),
      //   ),
      //   elevation: 0,
      // ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
  }
}
