import 'dart:io';

import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/dataproviders/firebase_providers/firestore_provider.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/storage_repo.dart';
import 'package:carrypill_rider/data/models/profile.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class ProfileInfo extends StatefulWidget {
  final Rider rider;
  const ProfileInfo({Key? key, required this.rider}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final dateOfBirthcon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateBirth;
  String? gender, filePath, fileName;
  File? file;
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
                  child: filePath == null
                      ? DottedBorder(
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
                        )
                      : ClipRRect(
                          borderRadius: borderRadiuscR(r: 4),
                          child: SizedBox(
                            height: 136.w,
                            width: 300.w,
                            child: Image.file(
                              File(filePath!),
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
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.image,
                      );
                      print(results);
                      if (results != null) {
                        final path = results.files.single.path!;
                        //File file = File(path);
                        // Image(image: FileImage(file))
                        //     .image
                        //     .resolve(const ImageConfiguration())
                        //     .addListener(
                        //   ImageStreamListener(
                        //     (ImageInfo info, bool syncCall) {
                        //       int width = info.image.width;
                        //       int height = info.image.height;
                        //       print(width);
                        //       print(height);
                        //     },
                        //   ),
                        // );
                        final img.Image? image =
                            img.decodeImage(await File(path).readAsBytes());
                        final img.Image orientedImage =
                            img.bakeOrientation(image!);
                        File newfile = await File(path)
                            .writeAsBytes(img.encodeJpg(orientedImage));

                        setState(() {
                          file = newfile;
                          filePath = path;
                          fileName = results.files.single.name;
                        });
                      }
                    },
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
                        readOnly: true,
                        onTap: () async => pickDate(),
                        decoration: inputDeco(
                          isDate: true,
                          contentPadding: padSymR(),
                          borderColor: kchintTextfield,
                          borderEnableColor: kchintTextfield,
                          fsHint: 14,
                          fwHint: kfregular,
                          onPressedTrailing: pickDate,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (filePath != null && gender != null) {
                        //todo storage
                        final String? url =
                            await StorageRepo(uid: widget.rider.documentID)
                                .uploadRiderProfileImage(filePath!, fileName!);
                        print(url);
                        if (url != null) {
                          Profile profile = Profile(
                              gender: gender,
                              profileImageUrl: url,
                              birthDate: _dateBirth);
                          await FirestoreRepo(uid: widget.rider.documentID)
                              .updateRiderProfileInfo(profile);
                          if (!mounted) return;
                          Navigator.of(context).pop();
                        } else {
                          if (!mounted) return;
                          kwShowSnackbar(context, 'error upload file');
                        }
                      } else {
                        kwShowSnackbar(context,
                            'Please fill in all the required information');
                      }
                    } else {
                      kwShowSnackbar(context,
                          'Please fill in all the required information');
                    }
                  },
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
        dateOfBirthcon.text = DateFormat("dd MMMM, yyyy").format(_dateBirth!);
      });
    });
  }
}
