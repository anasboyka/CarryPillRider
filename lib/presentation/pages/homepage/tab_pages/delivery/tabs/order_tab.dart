import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatefulWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  State<OrderTab> createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: kcBgHome,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                //color: kcWhite,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                  color: kcWhite,
                ),
                child: Padding(
                  padding: padSymR(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gaphr(h: 17),
                      Text(
                        'Healthcare facility',
                        style: kwtextStyleRD(
                            c: kcGreyLabel2, fs: 14, fw: FontWeight.w500),
                      ),
                      gaphr(h: 5),
                      Text(
                        'Hospital Sultan Abdul Halim',
                        style: kwtextStyleRD(
                          fs: 20,
                          fw: FontWeight.bold,
                        ),
                      ),
                      gaphr(h: 14),
                    ],
                  ),
                ),
              ),
              gaphr(),
              Padding(
                padding: padSymR(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: kcWhite,
                      borderRadius: borderRadiuscR(r: 16),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.16),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gaphr(),
                      Padding(
                        padding: padSymR(),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: borderRadiuscR(r: 10),
                            color: kcBgHome,
                          ),
                          child: Padding(
                            padding: padOnlyR(t: 10, b: 10),
                            child: Text(
                              'Order Details',
                              style: kwtextStyleRD(
                                  fs: 15, c: kcBlack2, fw: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      gaphr(h: 10),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: padSymR(),
                          onTap: () {
                            print('press');
                          },
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gaphr(h: 10),
                                    Text(
                                      'Customer Name:',
                                      style: kwtextStyleRD(
                                          c: kcBlack,
                                          fs: 14,
                                          fw: FontWeight.bold),
                                    ),
                                    gaphr(h: 5),
                                    Text(
                                      'Iqbal Fakhri Bin Iylia Shuhaimi',
                                      style: kwtextStyleRD(
                                        c: kcPrimary,
                                        fs: 20,
                                        fw: FontWeight.w500,
                                      ),
                                    ),
                                    gaphr(h: 16)
                                  ],
                                ),
                              ),
                              IconButton(
                                iconSize: 24,
                                padding: EdgeInsets.zero,
                                splashRadius: 18,
                                constraints: const BoxConstraints(
                                    maxHeight: 24, maxWidth: 24),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kcPrimary,
                                ),
                              ),
                              gapwr(w: 15),
                              IconButton(
                                iconSize: 24,
                                padding: EdgeInsets.zero,
                                splashRadius: 18,
                                constraints: const BoxConstraints(
                                    maxHeight: 24, maxWidth: 24),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.message,
                                  color: kcPrimary,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      divider(c: kcdisabledBtn, t: 1.3),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: padSymR(),
                          onTap: () {
                            print('press');
                          },
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gaphr(h: 10),
                              Text(
                                'IC Number:',
                                style: kwtextStyleRD(
                                    c: kcBlack, fs: 14, fw: FontWeight.bold),
                              ),
                              gaphr(h: 5),
                              Text(
                                '001234-02-1234',
                                style: kwtextStyleRD(
                                  c: kcPrimary,
                                  fs: 20,
                                  fw: FontWeight.w500,
                                ),
                              ),
                              gaphr(h: 16)
                            ],
                          ),
                        ),
                      ),
                      divider(c: kcdisabledBtn, t: 1.3),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: padSymR(),
                          onTap: () {
                            print('press');
                          },
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gaphr(h: 10),
                              Text(
                                'Hospital ID number:',
                                style: kwtextStyleRD(
                                    c: kcBlack, fs: 14, fw: FontWeight.bold),
                              ),
                              gaphr(h: 5),
                              Text(
                                'SP00695962',
                                style: kwtextStyleRD(
                                  c: kcPrimary,
                                  fs: 20,
                                  fw: FontWeight.w500,
                                ),
                              ),
                              gaphr(h: 16)
                            ],
                          ),
                        ),
                      ),
                      divider(c: kcdisabledBtn, t: 1.3),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: padSymR(),
                          onTap: () {
                            print('press');
                          },
                          title: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gaphr(h: 10),
                                    Text(
                                      'Address:',
                                      style: kwtextStyleRD(
                                          c: kcBlack,
                                          fs: 14,
                                          fw: FontWeight.bold),
                                    ),
                                    gaphr(h: 5),
                                    Text(
                                      'MAXIM CITY LIGHTS Building, JALAN SENTUL PASAR Section TAMAN PELANGI, 51100 KUALA LUMPUR WILAYAH PERSEKUTUAN',
                                      style: kwtextStyleRD(
                                        c: kcPrimary,
                                        fs: 12,
                                        fw: FontWeight.w500,
                                      ),
                                    ),
                                    gaphr(h: 16)
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.location_pin,
                                    color: kcPrimary,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      divider(c: kcdisabledBtn, t: 1.3),
                      Material(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: padSymR(),
                          onTap: () {
                            print('press');
                          },
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gaphr(h: 10),
                              Text(
                                'Payment:',
                                style: kwtextStyleRD(
                                    c: kcBlack, fs: 14, fw: FontWeight.bold),
                              ),
                              gaphr(h: 5),
                              Text(
                                'Online banking',
                                style: kwtextStyleRD(
                                  c: kcPrimary,
                                  fs: 20,
                                  fw: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      gaphr(),
                    ],
                  ),
                ),
              ),
              gaphr(),
            ],
          ),
        ));
  }
}
