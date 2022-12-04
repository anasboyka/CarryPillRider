import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final dateOfBirthcon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? gender;
  List<String> genders = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kcWhite,
        elevation: 0,
        shadowColor: kcTransparent,
        title: Text(
          'Profile',
          style: kwtextStyleRD(fs: 20, fw: kfbold, c: kcPrimary),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: kcWhite,
        child: SingleChildScrollView(
          child: Padding(
            padding: padSymR(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gaphr(h: 10),
                titleInput('Profile photo'),
                gaphr(),
                Align(
                  alignment: Alignment.center,
                  child: DottedBorder(
                    dashPattern: const [7, 7],
                    color: kcborderGrey,
                    strokeWidth: 1,
                    child: Container(
                      height: 136.w,
                      width: 136.w,
                      decoration: BoxDecoration(
                        color: kcImageContainer,
                        borderRadius: borderRadiuscR(r: 4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_a_photo,
                          color: kcgrey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    minWidth: 136.w,
                    height: 26,
                    color: kcPrimary,
                    shape: cornerR(r: 4),
                    onPressed: () {},
                    child: Text(
                      'Browse file',
                      style: kwtextStyleRD(fs: 14, fw: kfbold, c: kcWhite),
                    ),
                  ),
                ),
                gaphr(h: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleInput('Date of Birth'),
                      gaphr(h: 12),
                      TextFormField(
                        controller: dateOfBirthcon,
                        style: kwtextStyleRD(
                          c: kcPrimary,
                          fs: 12,
                          fw: kfsemibold,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field cannot be empty";
                          }
                          return null;
                        },
                        decoration: inputDeco(
                          contentPadding: padSymR(),
                          borderColor: kchintTextfield,
                          borderEnableColor: kchintTextfield,
                          fsHint: 14,
                          fwHint: kfregular,
                        ),
                      ),
                      gaphr(),
                      titleInput('Gender'),
                      gaphr(h: 12),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          style: kwtextStyleRD(
                            c: kcPrimary,
                            fs: 12,
                            fw: FontWeight.w600,
                          ),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: kchintTextfield,
                              width: 1,
                            ),
                          ),
                          buttonWidth: double.infinity,
                          buttonPadding: padOnlyR(l: 20, r: 5),
                          icon: Icon(
                            Icons.expand_more,
                            size: 35,
                            color: gender != null ? kcPrimary : kchintTextfield,
                          ),
                          value: gender,
                          items: genders
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                gaphr(h: 200),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 64,
                  color: kcPrimary,
                  shape: cornerR(r: 12),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: kwtextStyleRD(
                      fs: 20,
                      fw: kfbold,
                      c: kcWhite,
                    ),
                  ),
                ),
                gaphr(h: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleInput(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: kwtextStyleRD(
            fs: 18,
            fw: kfmedium,
          ),
        ),
        Text(
          '(Required)',
          style: kwtextStyleRD(
            c: kcRedRequired,
            fs: 14,
          ),
        ),
      ],
    );
  }
}
