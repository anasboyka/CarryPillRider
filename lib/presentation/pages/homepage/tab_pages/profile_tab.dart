import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    Rider? rider = Provider.of<Rider?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${rider?.firstName}', style: kwtextStyleRD(c: kcBlack)),
      ),
      body: Container(),
    );
  }
}
