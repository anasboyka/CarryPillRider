import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Startup extends StatefulWidget {
  const Startup({Key? key}) : super(key: key);

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  List<String> states = [
    "Kedah",
    "Kuala Lumpur",
    "Negeri Sembilan",
    "Sabah",
    "Perak",
    "Perlis",
    "Terengganu",
    "Selangor",
    "Pahang",
    "Sarawak",
    "Melaka",
    "Johor",
    "Kelantan",
    "Penang",
  ];

  String value = "Kedah";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        //mainAxisSize: MainAxisSize.max,
        children: [
          gaphr(h: 82),
          Lottie.asset('assets/lottie/startup.json'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                gaphr(h: 62),
                Text(
                  'Welcome to carrypill rider app',
                  style: kwtextStyleRD(fs: 30, fw: FontWeight.bold),
                ),
                gaphr(h: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: kcborderGrey,
                    ),
                    borderRadius: borderRadiuscR(r: 12),
                  ),
                  height: 60.h,
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      dropdownMaxHeight: 280,
                      buttonPadding: padOnly(l: 20, r: 10),
                      icon: const Icon(
                        Icons.expand_more,
                        size: 35,
                        color: kcPrimary,
                      ),

                      value: value,
                      onChanged: (items) {
                        setState(() {
                          value = items!;
                        });
                      },

                      //itemHeight: 10,
                      items: states
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: kwtextStyleRD(
                                  fs: 20,
                                  fw: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                gaphr(h: 24),
                MaterialButton(
                  height: 64.h,
                  minWidth: double.infinity,
                  color: kcPrimary,
                  shape: cornerR(r: 12),
                  child: Text(
                    'Next',
                    style: kwtextStyleRD(
                      c: kcWhite,
                      fw: FontWeight.bold,
                      fs: 20,
                    ),
                  ),
                  onPressed: () {
                    //TODO navigate to sign in
                    Navigator.of(context).pushNamed('/signin');
                    print('goto signin');
                  },
                ),
                gaphr(h: 30),
                Row(
                  children: [
                    const Text(
                      'Not registered yet?',
                      style: kwstyleb16,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                        print('goto signup');
                      },
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Become a Rider',
                            style: kwtextStyleRD(
                              c: kcPrimary,
                              fw: FontWeight.bold,
                              fs: 18,
                            ),
                          ),
                          gapwr(w: 10),
                          const Icon(
                            CupertinoIcons.arrow_up_right_square_fill,
                            color: kcPrimary,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                gaphr(h: 51.h),
                const Text(
                  'v1.0.0',
                  style: kwstyleb14,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
