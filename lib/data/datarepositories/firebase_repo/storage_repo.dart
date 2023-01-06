import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  final String? uid;

  StorageRepo({this.uid});

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadRiderProfileImage(
      String filePath, String fileName) async {
    File file = File(filePath);
    final ref = storage.ref().child('riders').child('/$uid/');

    try {
      await ref.child('profilepic').putFile(file);
      return await ref.child('profilepic').getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> uploadOrderTokenImage(File file) async {
    // File file = File(filePath);
    final ref = storage.ref().child('orders').child('/$uid/');

    try {
      await ref.child('tokenImage').putFile(file);
      return await ref.child('tokenImage').getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> uploadRiderDriverLicenseImage(
      File file, String fileName) async {
    //File file = File(filePath);
    final ref = storage.ref().child('riders').child('/$uid/');
    Uint8List bytesdata = file.readAsBytesSync();
    try {
      // await ref.child('driverlicense').putData(bytesdata);
      final TaskSnapshot snapshot =
          await ref.child('driverLicense').putFile(file);
      //print(snapshot);
      return await snapshot.ref.getDownloadURL();
      // return await ref.child('driverLicense').getDownloadURL();
    } catch (e) {
      print(e);
      try {
        final TaskSnapshot snapshot =
            await ref.child('driverLicense').putData(bytesdata);
        //print(await snapshot.ref.getDownloadURL());
        return await snapshot.ref.getDownloadURL();
        // return await ref.child('driverLicense').getDownloadURL();
      } on Exception catch (e) {
        print(e);
        return null;
      }
    }
  }
}
