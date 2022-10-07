import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryTab extends StatefulWidget {
  const DeliveryTab({Key? key}) : super(key: key);

  @override
  State<DeliveryTab> createState() => _DeliveryTabState();
}

class _DeliveryTabState extends State<DeliveryTab> {
  bool isWorking = true, autoAccept = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: kcWhite,
        title: const Text('Status'),
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: padSymR(),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
              color: kcWhite,
            ),
            child: Row(
              children: [
                Container(
                  //height: 33,
                  decoration: BoxDecoration(
                      color: isWorking ? kcstatusGreen : kcdisabledBtn,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                    child: Text(
                      isWorking ? 'Working' : 'Not Working',
                      style: kwtextStyleRD(
                        fs: 14,
                        fw: FontWeight.w500,
                        c: isWorking ? kcWhite : kcBlack,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                isWorking
                    ? Text(
                        'Auto accept order',
                        style: kwtextStyleRD(
                          fs: 16,
                          fw: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
                const Spacer(),
                isWorking
                    ? Switch.adaptive(
                        activeColor: kcstatusGreen,
                        value: autoAccept,
                        onChanged: (value) {
                          setState(() {
                            autoAccept = value;
                          });
                        })
                    : const SizedBox()
              ],
            ),
          ),
          gaphr(h: 44),
          Padding(
            padding: padSymR(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kcWhite,
                      borderRadius: borderRadiuscR(r: 8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ]),
                  child: Padding(
                    padding: padSymR(v: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aug 1 - 15, 2022',
                          style: kwtextStyleRD(
                            fs: 16,
                            fw: FontWeight.w500,
                          ),
                        ),
                        gaphr(h: 8),
                        Text(
                          '+RM 432.00',
                          style: kwtextStyleRD(
                            fs: 16,
                            fw: FontWeight.bold,
                            c: kcProfit,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                gaphr(h: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kcWhite,
                    borderRadius: borderRadiuscR(r: 8),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: padSymR(
                      v: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kcBgHome,
                            borderRadius: borderRadiuscR(r: 8),
                          ),
                          child: Padding(
                            padding: padSymR(v: 8, h: 8),
                            child: Text(
                              '04 Aug, Thursday',
                              style: kwtextStyleRD(fs: 20, fw: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        gaphr(h: 40),
                        Row(
                          children: [
                            Text(
                              isWorking
                                  ? "Recent profit: "
                                  : "Current profit: ",
                              style: kwtextStyleRD(
                                fs: 18,
                                fw: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '+RM 24.00',
                              style: kwtextStyleRD(
                                  c: kcProfit, fs: 18, fw: FontWeight.bold),
                            )
                          ],
                        ),
                        gaphr(),
                        Text(
                          isWorking
                              ? 'Recomended work time : 3 hours'
                              : 'Current working hours: 3 hours',
                          style: kwtextStyleRD(
                            fs: 16,
                            fw: FontWeight.w500,
                          ),
                        ),
                        gaphr(h: isWorking ? 0 : 20),
                        isWorking
                            ? const SizedBox()
                            : const Text(
                                'are you ready?',
                                style: kwstyleb16,
                              ),
                        gaphr(),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 64,
                          color: kcPrimary,
                          shape: cornerR(
                            r: 8,
                          ),
                          onPressed: () {},
                          child: Text(
                            isWorking ? 'End Shift' : 'Start Working Now',
                            style: kwtextStyleRD(
                                c: kcWhite, fs: 20, fw: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
