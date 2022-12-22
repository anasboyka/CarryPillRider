import 'dart:io';

import 'package:carrypill_rider/constant/constant_color.dart';
import 'package:carrypill_rider/constant/constant_widget.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill_rider/data/datarepositories/firebase_repo/storage_repo.dart';
import 'package:carrypill_rider/data/models/rider.dart';
import 'package:carrypill_rider/data/models/vehicle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as img;

class VehicleInfo extends StatefulWidget {
  final Rider rider;
  const VehicleInfo({Key? key, required this.rider}) : super(key: key);

  @override
  State<VehicleInfo> createState() => _VehicleInfoState();
}

class _VehicleInfoState extends State<VehicleInfo> {
  final plateNumCon = TextEditingController();
  final vehicleBrandCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? fileName;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kcWhite,
        elevation: 0,
        shadowColor: kcTransparent,
        title: Text(
          'Vehicle info',
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleInput('Vehicle Name'),
                      gaphr(h: 12),
                      TextFormField(
                        controller: vehicleBrandCon,
                        style: kwtextStyleRD(
                          c: kcPrimary,
                          fs: 14,
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
                      titleInput('Vehicle Plate Number'),
                      gaphr(h: 12),
                      TextFormField(
                        controller: plateNumCon,
                        style: kwtextStyleRD(
                          c: kcPrimary,
                          fs: 14,
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
                    ],
                  ),
                ),
                titleInput('Driver\'s License'),
                gaphr(),
                Align(
                  alignment: Alignment.center,
                  child: file == null
                      ? DottedBorder(
                          dashPattern: const [7, 7],
                          color: kcborderGrey,
                          strokeWidth: 1,
                          child: Container(
                            height: 136.w,
                            width: 220.w,
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
                          borderRadius: borderRadiuscR(r: 10),
                          child: SizedBox(
                            //height: 136.w,
                            width: 220.w,
                            child: Image.file(file! // File(filePath!),
                                ),
                          ),
                        ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    minWidth: 221.w,
                    height: 26,
                    color: kcPrimary,
                    shape: cornerR(r: 4),
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg']);
                      // print(results);
                      if (results != null) {
                        final path = results.files.single.path!;
                        print(path);
                        File pickedfile = File(path);
                        Image(image: FileImage(pickedfile))
                            .image
                            .resolve(const ImageConfiguration())
                            .addListener(
                          ImageStreamListener(
                            (ImageInfo info, bool syncCall) {
                              int width = info.image.width;
                              int height = info.image.height;
                              print(width);
                              print(height);
                            },
                          ),
                        );
                        final img.Image? image =
                            img.decodeImage(await File(path).readAsBytes());
                        print(image);
                        final img.Image orientedImage =
                            img.bakeOrientation(image!);
                        File newfile = await File(path)
                            .writeAsBytes(img.encodePng(orientedImage));
                        setState(() {
                          file = newfile;
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
                gaphr(h: 290),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 64,
                  color: kcPrimary,
                  shape: cornerR(r: 12),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (file != null) {
                        //todo storage
                        final String? url = await StorageRepo(
                                uid: widget.rider.documentID)
                            .uploadRiderDriverLicenseImage(file!, fileName!);
                        // print(url);
                        if (url != null) {
                          Vehicle vehicle = Vehicle(
                            riderLicense: url,
                            vehiclePlateNum: plateNumCon.text.toUpperCase(),
                            vehicleBrand: vehicleBrandCon.text.toUpperCase(),
                          );
                          await FirestoreRepo(uid: widget.rider.documentID)
                              .updateRiderVehicleInfo(vehicle);
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
}
