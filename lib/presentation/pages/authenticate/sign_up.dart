import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fnameCon = TextEditingController();
  TextEditingController lnameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController pass1Con = TextEditingController();
  TextEditingController pass2Con = TextEditingController();
  TextEditingController phoneNumCon = TextEditingController();

  bool isHidden1 = true, isHidden2 = true, isComplete = false;
  String? vehicleType;
  List<String> vehicleTypeList = ["Car", "Motorcycle", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: padSymR(),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 35,
              height: 35,
              child: IconButton(
                alignment: Alignment.center,
                splashRadius: 20,
                padding: EdgeInsets.zero,
                iconSize: 35,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  size: 35,
                  Icons.arrow_back,
                  color: kcPrimary,
                ),
              ),
            ),
          ),
          gaphr(h: 17),
          const Text(
            'Sign up as rider',
            style: kwstyleHeaderb30Bold,
          ),
          gaphr(),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: fnameCon,
                  style: kwtextStyleRD(
                    c: kcPrimary,
                    fs: 18,
                    fw: FontWeight.w600,
                  ),
                  decoration: inputDeco(
                    hint: "First Name",
                  ),
                ),
              ),
              gapwr(w: 10),
              Expanded(
                child: TextFormField(
                  controller: lnameCon,
                  style: kwtextStyleRD(
                    c: kcPrimary,
                    fs: 18,
                    fw: FontWeight.w600,
                  ),
                  decoration: inputDeco(
                    hint: "Last Name",
                  ),
                ),
              ),
            ],
          ),
          gaphr(),
          TextFormField(
            controller: emailCon,
            style: kwtextStyleRD(
              c: kcPrimary,
              fs: 18,
              fw: FontWeight.w600,
            ),
            decoration: inputDeco(
              hint: "Email",
            ),
          ),
          gaphr(),
          TextFormField(
            obscureText: isHidden1,
            controller: pass1Con,
            style: kwtextStyleRD(
              c: kcPrimary,
              fs: 18,
              fw: FontWeight.w600,
            ),
            decoration: inputDeco(
              hint: "Password",
              isHidden: isHidden1,
              isPassword: true,
              onPressedTrailing: () {
                setState(() {
                  isHidden1 = !isHidden1;
                });
              },
            ),
          ),
          gaphr(),
          TextFormField(
            obscureText: isHidden2,
            controller: pass2Con,
            style: kwtextStyleRD(
              c: kcPrimary,
              fs: 18,
              fw: FontWeight.w600,
            ),
            decoration: inputDeco(
              hint: "Confirm Password",
              isHidden: isHidden2,
              isPassword: true,
              onPressedTrailing: () {
                setState(() {
                  isHidden2 = !isHidden2;
                });
              },
            ),
          ),
          gaphr(),
          Row(
            children: [
              Text(
                '+60',
                style: kwtextStyleRD(
                  c: kcgrey,
                  fs: 18,
                  fw: FontWeight.w600,
                ),
              ),
              gapwr(w: 10),
              Expanded(
                child: TextFormField(
                  controller: emailCon,
                  style: kwtextStyleRD(
                    c: kcPrimary,
                    fs: 18,
                    fw: FontWeight.w600,
                  ),
                  decoration: inputDeco(
                    hint: "Phone Number",
                  ),
                ),
              ),
            ],
          ),
          gaphr(),
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              style: kwtextStyleRD(
                c: kcPrimary,
                fs: 18,
                fw: FontWeight.w600,
              ),
              hint: Text(
                'What is your vehicle type?',
                style: kwtextStyleRD(
                  c: kchintTextfield,
                  fs: 18,
                  fw: FontWeight.w600,
                ),
              ),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: kcborderGrey,
                  width: 3,
                ),
              ),
              buttonPadding: padOnlyR(l: 20, r: 5),
              icon: Icon(
                Icons.expand_more,
                size: 35,
                color: vehicleType != null ? kcPrimary : kchintTextfield,
              ),
              value: vehicleType,
              items: vehicleTypeList
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  vehicleType = value!;
                });
              },
            ),
          ),
          gaphr(h: 94),
          MaterialButton(
            elevation: 0,
            height: 64.h,
            minWidth: double.infinity,
            color: isComplete ? kcPrimary : kcdisabledBtn,
            shape: cornerR(r: 12),
            child: Text(
              'Sign up',
              style: kwtextStyleRD(
                c: isComplete ? kcWhite : kcgrey,
                fs: 20,
                fw: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
