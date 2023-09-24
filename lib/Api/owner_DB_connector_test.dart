import 'dart:io';

import 'package:classcar/module/car_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class OwnerDataConnector {
  static final firestore = FirebaseFirestore.instance;
  static var userIdInfo;

  static Future<int> addData(
      String OwnerUid, Map<String, dynamic> userInfo) async {
    bool check = false;
    await firestore
        .collection('OwnerInfoTets')
        .add(userInfo)
        .then((value) => {check = true});
    if (check) {
      return 0;
    }
    return 1;
  }
}
