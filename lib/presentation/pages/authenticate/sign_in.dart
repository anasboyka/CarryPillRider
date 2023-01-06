import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcon = TextEditingController();
  TextEditingController passcon = TextEditingController();

  bool isHidden = true, isComplete = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: padSymR(),
            child: childContent(context, isKeyboardinput: true),
          ),
        ),
      ),
    );
  }

  Widget childContent(BuildContext context, {bool isKeyboardinput = false}) {
    return Column(
      //padding: padSymR(),
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
          'Please sign in',
          style: kwstyleHeaderb30Bold,
        ),
        gaphr(h: 40),
        TextFormField(
          onChanged: (value) {
            // print(value);
            if (passcon.text.isNotEmpty && value != "") {
              setState(() {
                isComplete = true;
              });
            } else {
              setState(() {
                isComplete = false;
              });
            }
          },
          controller: emailcon,
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
          onChanged: (value) {
            if (emailcon.text.isNotEmpty && value != "") {
              setState(() {
                isComplete = true;
              });
            } else {
              setState(() {
                isComplete = false;
              });
            }
          },
          obscureText: isHidden,
          controller: passcon,
          style: kwtextStyleRD(
            c: kcPrimary,
            fs: 18,
            fw: FontWeight.w600,
          ),
          decoration: inputDeco(
            onPressedTrailing: () {
              setState(() {
                isHidden = !isHidden;
              });
            },
            isHidden: isHidden,
            isPassword: true,
            hint: "Password",
          ),
        ),
        gaphr(h: 32),
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Text(
              'Forgot password?',
              style: kwtextStyleRD(
                c: kcPrimary,
                fs: 17,
                fw: FontWeight.w600,
              ),
            ),
          ),
        ),
        gaphr(h: 265),
        //isKeyboardinput ? gaphr(h: 245) : const Spacer(),
        MaterialButton(
          enableFeedback: false,
          elevation: 0,
          height: 64.h,
          minWidth: double.infinity,
          //focusElevation: 0,
          highlightElevation: 0,
          highlightColor: isComplete ? null : Colors.transparent,
          splashColor: isComplete ? null : Colors.transparent,
          color: isComplete ? kcPrimary : kcdisabledBtn,
          shape: cornerR(r: 12),
          child: Text(
            'Sign in',
            style: kwtextStyleRD(
              c: isComplete ? kcWhite : kcgrey,
              fs: 20,
              fw: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            if (isComplete) {
              setState(() {
                loading = true;
              });
              try {
                dynamic result = await AuthRepo()
                    .signInWithEmailAndPassword(emailcon.text, passcon.text);
                if (!mounted) return;
                Navigator.of(context).pop();
                print('sign in');
                // print(result);
              } on Exception catch (e) {
                kwShowSnackbar(context, 'error $e');
                // TODO
              }
              setState(() {
                loading = false;
              });
            }
          },
        ),
        isKeyboardinput ? gaphr(h: 0) : gaphr(h: 130),
      ],
    );
  }
}
