import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';

class ShiftTab extends StatefulWidget {
  const ShiftTab({Key? key}) : super(key: key);

  @override
  State<ShiftTab> createState() => _ShiftTabState();
}

class _ShiftTabState extends State<ShiftTab> {
  bool isWorking = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padSymR(),
      child: Column(
        children: [
          gaphr(h: 44),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: kcWhite,
                borderRadius: borderRadiuscR(r: 8),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.16),
                  )
                ]),
            child: Padding(
              padding: padSymR(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gaphr(h: 16),
                  Text(
                    'Aug 1 - 4,2022',
                    style:
                        kwtextStyleRD(fw: FontWeight.w500, fs: 16, c: kcBlack2),
                  ),
                  gaphr(h: 8),
                  Text(
                    '+RM 72.00',
                    style:
                        kwtextStyleRD(fw: FontWeight.bold, fs: 16, c: kcProfit),
                  ),
                  gaphr(h: 15),
                ],
              ),
            ),
          ),
          gaphr(h: 30),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: borderRadiuscR(r: 17),
                color: kcWhite,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.16),
                  )
                ]),
            child: Padding(
              padding: padSymR(v: 20),
              child: Column(
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
                        isWorking ? "Recent profit: " : "Current profit: ",
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
    );
  }
}
