import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({Key? key}) : super(key: key);

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kcWhite,
        shadowColor: kcTransparent,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: kcPrimary,
              size: 35,
            )),
      ),
      body: Container(
        color: kcWhite,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padSymR(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete your detail',
                    style: kwtextStyleRD(
                      fs: 30,
                      fw: kfbold,
                    ),
                  ),
                  gaphr(h: 12),
                  dividerC(c: kcborderGrey, t: 10),
                  gaphr(),
                  Text(
                    'Personal',
                    style: kwtextStyleRD(
                      c: kcgrey,
                      fs: 28,
                      fw: kfmedium,
                    ),
                  ),
                  gaphr(h: 32),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: kcTransparent,
                  child: ListTile(
                    title: Text(
                      'Profile Info',
                      style: kwtextStyleRD(
                        fs: 18,
                        fw: kfmedium,
                        c: kcgrey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Required',
                          style: kwtextStyleRD(
                            fs: 14,
                            c: kcRedRequired,
                            fw: kfmedium,
                          ),
                        ),
                        //gapwr(w: 8),
                        const Icon(
                          Icons.chevron_right,
                          size: 32,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/profileinfo');
                      print('tap');
                    },
                    contentPadding: padSymR(),
                  ),
                ),
                Padding(
                  padding: padSymR(),
                  child: divider(c: kcborderGrey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: kcTransparent,
                  child: ListTile(
                    title: Text(
                      'Vehicle Info',
                      style: kwtextStyleRD(
                        fs: 18,
                        fw: kfmedium,
                        c: kcgrey,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Required',
                          style: kwtextStyleRD(
                            fs: 14,
                            c: kcRedRequired,
                            fw: kfmedium,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 32,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/vehicleinfo');
                      print('tap');
                    },
                    contentPadding: padSymR(),
                  ),
                ),
                Padding(
                  padding: padSymR(),
                  child: divider(c: kcborderGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
