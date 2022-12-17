import 'dart:ui';

import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_string.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/auth_repo.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/logic/cubit/auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: Scaffold(body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.loading ? true : false,
            child: Stack(
              children: [
                Opacity(
                  opacity: state.loading ? 1 : 0,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400.withOpacity(0.7)),
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: kcPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Form(
                    key: _formKey,
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
                              onPressed: () async {
                                print('sign in');
                                AuthRepo().signInWithEmailAndPassword(
                                    'testrider9@gmail.com', '123456');

                                // BlocProvider.of<AuthCubit>(context)
                                //     .loadingStart();
                                //Navigator.of(context).pop();
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "field cannot be empty";
                                  }

                                  return null;
                                },
                                decoration: inputDeco(
                                  borderWidth: 3,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "field cannot be empty";
                                  }
                                  return null;
                                },
                                decoration: inputDeco(
                                  borderWidth: 3,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty";
                            }
                            return null;
                          },
                          decoration: inputDeco(
                            borderWidth: 3,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty";
                            }
                            return null;
                          },
                          decoration: inputDeco(
                            borderWidth: 3,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "field cannot be empty";
                            }
                            return null;
                          },
                          decoration: inputDeco(
                            borderWidth: 3,
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
                                controller: phoneNumCon,
                                style: kwtextStyleRD(
                                  c: kcPrimary,
                                  fs: 18,
                                  fw: FontWeight.w600,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "field cannot be empty";
                                  }
                                  return null;
                                },
                                decoration: inputDeco(
                                  borderWidth: 3,
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
                              color: vehicleType != null
                                  ? kcPrimary
                                  : kchintTextfield,
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
                          color: !isComplete ? kcPrimary : kcdisabledBtn,
                          shape: cornerR(r: 12),
                          child: Text(
                            'Sign up',
                            style: kwtextStyleRD(
                              c: !isComplete ? kcWhite : kcgrey,
                              fs: 20,
                              fw: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            //TODO sign up
                            if (_formKey.currentState!.validate() &&
                                vehicleType != null) {
                              BlocProvider.of<AuthCubit>(context)
                                  .loadingStart();
                              Rider rider = Rider(
                                firstName: fnameCon.text,
                                lastName: lnameCon.text,
                                phoneNum: phoneNumCon.text,
                                vehicleType: vehicleType!,
                                workingStatus: ksNotWorking,
                                isWorking: false,
                                autoAccept: false,
                              );
                              dynamic result =
                                  await AuthRepo().signUpWithEmailAndPassword(
                                emailCon.text.trim(),
                                pass1Con.text,
                              );
                              print(result);
                              // Rider rider = Rider(
                              //   firstName: 'Alif',
                              //   lastName: 'Zakwan',
                              //   phoneNum: '0123459876',
                              //   vehicleType: 'kereyta',
                              //   workingStatus: 'not working',
                              //   isWorking: false,
                              //   autoAccept: false,
                              //   isProfileComplete: false,
                              // );
                              // dynamic result =
                              //     await AuthRepo().signUpWithEmailAndPassword(
                              //   'testrider3@gmail.com', //emailCon.text.trim(),
                              //   '123456', //pass1Con.text,
                              // );

                              if (result is UserCredential) {
                                User? user = result.user;
                                if (user != null) {
                                  await FirestoreRepo(uid: result.user!.uid)
                                      .createRider(rider);
                                  //TODO navigation
                                  // print('pass navigation');
                                } else {
                                  if (!mounted) return;
                                  kwShowSnackbar(context, "Error Sign Up");
                                }
                              } else if (result is String) {
                                //TODO sign in
                                if (result == ksErrorEmailAlreadyUsed) {
                                  if (!mounted) return;
                                  kwShowSnackbar(context,
                                      'Email already exist, Please login',
                                      seconds: 2);
                                }
                              }
                              if (!mounted) return;
                              BlocProvider.of<AuthCubit>(context)
                                  .loadingFinished();
                            } else {
                              kwShowSnackbar(context,
                                  'Please fill in all the required fieald');
                            }
                            //TODO navigator pop
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
