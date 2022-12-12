import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  double earning = 432.00098;
  @override
  Widget build(BuildContext context) {
    Rider? rider = Provider.of<Rider?>(context);
    return Scaffold(
      backgroundColor: kcBgHome,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: kwtextStyleRD(
            fs: 20,
            fw: kfbold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gaphr(h: 1),
            Container(
              //height: 216.h,
              width: double.infinity,
              //color: kcWhite,
              decoration: BoxDecoration(color: kcWhite, boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: kcBlack.withOpacity(0.16),
                  blurRadius: 3,
                )
              ]),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: kcTransparent,
                      child: IconButton(
                          padding: kwInset0,
                          iconSize: 24,
                          splashRadius: 20,
                          onPressed: () {
                            //TODO navigation tu profile update
                            Navigator.of(context)
                                .pushNamed('/profileupdate', arguments: rider);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: kcRequestPickupDescrp,
                          )),
                    ),
                  ),
                  CircleAvatar(
                      radius: 57.r,
                      backgroundImage: rider!.profile!.profileImageUrl != null
                          ? NetworkImage(rider.profile!.profileImageUrl!)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider),
                  gaphr(h: 15),
                  Text(
                    "${rider.firstName} ${rider.lastName}", //'Mohamed Salah',
                    style: kwtextStyleRD(
                      c: kcBlack2,
                      fs: 16,
                      fw: kfbold,
                    ),
                  ),
                  // gaphr(h: 3),
                  // Text(
                  //   '30',
                  //   style: kwtextStyleRD(
                  //     c: kcgrey,
                  //     fs: 14,
                  //     fw: kfregular,
                  //   ),
                  // ),
                  gaphr(),
                ],
              ),
            ),
            gaphr(),
            Padding(
              padding: padSymR(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: borderRadiuscR(
                    r: 8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                      color: kcBlack.withOpacity(0.16),
                    ),
                  ],
                ),
                child: Padding(
                  padding: padSymR(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gaphr(),
                      Text(
                        'Earning',
                        style: kwtextStyleRD(c: kcgrey, fs: 16, fw: kfmedium),
                      ),
                      //TODO earning
                      Text(
                        'RM${earning.toStringAsFixed(2)}',
                        style: kwtextStyleRD(fs: 26, fw: kfbold, c: kcProfit),
                      ),
                      gaphr(),
                      dividerC(c: kcborderGrey),
                      gaphr(h: 14),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: borderRadiuscR(r: 12),
                            child: Container(
                              width: 85.w,
                              height: 58.h,
                              decoration: const BoxDecoration(
                                color: kcBgHome,
                              ),
                              alignment: Alignment.center,
                              child: rider.vehicleType == "Motorcycle"
                                  ? Image.asset(
                                      'assets/images/motorcycle.png',
                                      width: 60,
                                    )
                                  : rider.vehicleType == "Car"
                                      ? Image.asset(
                                          'assets/images/car.png',
                                          width: 60,
                                        )
                                      : null,
                            ),
                          ),
                          gapwr(w: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rider.vehicle?.vehicleBrand ?? 'Yamaha Y15ZR',
                                style: kwtextStyleRD(
                                  fs: 16,
                                  fw: kfbold,
                                  c: kcBlack2,
                                ),
                              ),
                              Text(
                                rider.vehicle!.vehiclePlateNum!, //'ABC1234',
                                style: kwtextStyleRD(
                                  c: kcgrey,
                                  fs: 14,
                                  fw: kfbold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      gaphr(),
                      dividerC(c: kcborderGrey),
                      gaphr(h: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'Total order history:',
                                  style: kwtextStyleRD(
                                    c: kcgrey,
                                    fs: 16,
                                    fw: kfmedium,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '13',
                                  style: kwtextStyleRD(
                                    c: kcgrey,
                                    fs: 16,
                                    fw: kfbold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'Work time:',
                          //         style: kwtextStyleRD(
                          //           c: kcgrey,
                          //           fs: 16,
                          //           fw: kfmedium,
                          //         ),
                          //       ),
                          //       Text(
                          //         '4hrs',
                          //         style: kwtextStyleRD(
                          //           c: kcgrey,
                          //           fs: 16,
                          //           fw: kfbold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      gaphr(h: 12),
                    ],
                  ),
                ),
              ),
            ),
            gaphr(),
            dataTile(
              'Phone',
              rider.phoneNum,
            ),
            gaphr(),
            dataTile(
                'Gender',
                //'Male',
                rider.profile!.gender!),
            gaphr(),
            dataTile(
                'Birth date',
                //'6 Dec, 1992',
                dateformatText(rider.profile!.birthDate!)),
            gaphr(),
          ],
        ),
      ),
    );
  }

  Padding dataTile(String title, String data) {
    return Padding(
      padding: padSymR(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: borderRadiuscR(r: 8),
            color: kcWhite,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                color: kcBlack.withOpacity(0.16),
                blurRadius: 6,
              )
            ]),
        child: Padding(
          padding: padSymR(),
          child: Column(
            children: [
              gaphr(h: 14),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title, //'Phone',
                  style: kwtextStyleRD(
                    c: kchintTextfield,
                    fs: 14,
                    fw: kfmedium,
                  ),
                ),
              ),
              gaphr(h: 3),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data,
                  style: kwtextStyleRD(
                    c: kcBlack2,
                    fs: 18,
                    fw: kfmedium,
                  ),
                ),
              ),
              gaphr(h: 14),
            ],
          ),
        ),
      ),
    );
  }
}
