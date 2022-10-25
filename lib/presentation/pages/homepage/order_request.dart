import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRequest extends StatefulWidget {
  const OrderRequest({Key? key}) : super(key: key);

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  int durationToAccept = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: kcWhite,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Order',
              style: kwtextStyleRD(
                fs: 20,
                fw: FontWeight.bold,
              ),
            ),
            gaph(h: 5),
            const Text(
              'Delivery',
              style: kwstyleb14,
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Decline',
                style: kwtextStyleRD(fs: 22, fw: FontWeight.bold, c: kcPrimary),
              ))
        ],
      ),
      body: Column(
        children: [
          gaphr(h: 30),
          Padding(
            padding: padSymR(),
            child: Container(
              height: 268.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadiuscR(r: 14), color: kcborderGrey),
            ),
          ),
          gaphr(h: 22),
          Padding(
            padding: padSymR(),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delivery Details',
                style: kwstyleb14,
              ),
            ),
          ),
          gaphr(),
          Expanded(
            child: Padding(
              padding: padSymR(),
              child: ListView(
                //shrinkWrap: true,
                children: [
                  deliveryDetailDesign(
                    const Icon(
                      Icons.domain,
                    ),
                    "Pickup",
                    3.423,
                    6,
                    'Hospital Sultan Abdul Halim',
                    'Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah',
                    true,
                  ),
                  gaphr(h: 4),
                  deliveryDetailDesign(
                    const Icon(Icons.pin_drop),
                    "Drop-off",
                    5.87,
                    12,
                    "Iqbal Fakhri Bin Iylia",
                    "Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah",
                    false,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 155,
            width: double.infinity,
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: kcWhite,
                  color: kcPrimary,
                  value: 1,
                ),
                gaphr(h: 10),
                Text('$durationToAccept seconds to auto-decline',
                    style: kwtextStyleRD(
                      c: kcRequestPickupDescrp,
                      fs: 16,
                    )),
                gaphr(),
                Padding(
                  padding: padSymR(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You will earn',
                              style: kwstyleb16,
                            ),
                            gaph(h: 7),
                            Text(
                              'RM 12.00',
                              style: kwtextStyleRD(
                                c: kcProfit,
                                fs: 30,
                                fw: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          shape: cornerR(
                            r: 8,
                          ),
                          minWidth: double.infinity,
                          height: 64,
                          color: kcPrimary,
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            'Accept',
                            style: kwstyleBtn20b,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryDetailDesign(Icon icon, String title, double distance,
      int duration, String subtitleName, String address, bool stepper) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              icon,
              gaphr(h: 8),
              stepper
                  ? Expanded(
                      child: Container(
                        color: kcdisabledBtn,
                        width: 3,
                      ),
                    )
                  : const SizedBox(),
              gaphr(h: 4.5)
            ],
          ),
          gapwr(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title, //'Pickup',
                      style: kwtextStyleRD(fs: 16, fw: FontWeight.bold),
                    ),
                    Text(
                      '${distance.toStringAsFixed(1)}km ~ ${duration}min',
                      style: kwtextStyleRD(fs: 16, fw: FontWeight.bold),
                    ),
                  ],
                ),
                gaphr(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subtitleName, //'Hospital Sultan Abdul Halim',
                    style: kwtextStyleRD(
                      fs: 16,
                    ),
                  ),
                ),
                gaphr(h: 5),
                Text(
                  address, // 'Jalan Lencongan Timur, Bandar Aman Jaya, 08000 Sungai Petani, Kedah',
                  style: kwstyleb12,
                ),
                gaphr(h: 18),
              ],
            ),
          )
        ],
      ),
    );
  }
}
