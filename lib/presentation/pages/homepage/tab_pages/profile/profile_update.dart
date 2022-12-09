import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfileUpdate extends StatefulWidget {
  final Rider? rider;
  const ProfileUpdate({Key? key, required this.rider}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  late TextEditingController fnamecon;
  late TextEditingController lnamecon;
  late TextEditingController dateBirthcon;
  late TextEditingController phoneNumcon;

  List<bool> enabled = List.filled(5, false);
  FocusNode nodefname = FocusNode();
  FocusNode nodelname = FocusNode();
  FocusNode nodedateBirth = FocusNode();
  FocusNode nodephoneNum = FocusNode();

  late DateTime _dateBirth;

  @override
  void initState() {
    // TODO: implement initState
    fnamecon = TextEditingController(text: widget.rider!.firstName);
    lnamecon = TextEditingController(text: widget.rider!.lastName);
    phoneNumcon = TextEditingController(text: widget.rider!.phoneNum);
    dateBirthcon = TextEditingController(
        text: DateFormat('dd MMMM, yyyy')
            .format(widget.rider!.profile!.birthDate!));
    _dateBirth = widget.rider!.profile!.birthDate!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcBgHome,
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: kwtextStyleRD(
            fs: 20,
            fw: kfbold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padSymR(),
          child: Column(
            children: [
              gaphr(h: 30),
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/profile.png',
                        height: 115,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        elevation: 0,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50),
                          splashColor: Colors.grey.shade300.withOpacity(0.8),
                          highlightColor: Colors.grey.shade800.withOpacity(0.2),
                          child: Ink(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: kcWhite,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: kcWhite,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              gaphr(),
              cardTextFieldDesign(
                fnamecon,
                'First Name',
                nodefname,
                0,
              ),
              gaphr(),
              cardTextFieldDesign(
                lnamecon,
                "Last Name",
                nodelname,
                1,
              ),
              gaphr(),
              cardTextFieldDesign(
                phoneNumcon,
                "Phone Number",
                nodephoneNum,
                2,
              ),
              gaphr(),
              cardTextFieldDesign(
                dateBirthcon,
                "Date of Birth",
                nodedateBirth,
                3,
                date: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTextFieldDesign(
      TextEditingController controller,
      String label,
      FocusNode node,
      // String hintText,
      int index,
      {bool date = false}) {
    return Card(
      shape: cornerR(),
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: node,
                style: enabled[index] ? kwstyleb16 : kwstyleHint16,
                controller: controller,
                enabled: enabled[index],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  floatingLabelStyle: kwtextStyleRD(
                    c: kcLabelColor,
                    fs: 16,
                    fw: FontWeight.w500,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: label,
                  labelStyle: kwtextStyleRD(
                    c: kcLabelColor,
                    fs: 16,
                    fw: FontWeight.w500,
                  ),
                  // hintText: hintText,
                  // hintStyle: kwstyleHint16,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                if (!date) {
                  setState(() {
                    enabled[index] = !enabled[index];
                  });
                } else {
                  pickDate();
                }
              },
              splashRadius: 24,
              iconSize: 24,
              icon: Icon(
                enabled[index] ? Icons.check_rounded : Icons.edit_rounded,
                size: 24,
                color: kcPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }

  void pickDate() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _dateBirth = date;
        dateBirthcon.text = DateFormat("dd MMMM, yyyy").format(_dateBirth);
      });
    });
  }
}
