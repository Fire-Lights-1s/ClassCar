import 'dart:io';

import 'package:classcar/module/car_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CarDataConnector {
  static final fireStore = FirebaseFirestore.instance;
  static final fireStorage = FirebaseStorage.instance;
  static var carInfo;

  static Future<List<CarInfoModel>> getData() async {
    List<CarInfoModel> carInstances = [];
    await fireStore.collection('CarINFO').get().then((event) {
      for (var doc in event.docs) {
        carInfo = CarInfoModel.fromJson(doc.reference.id, doc.data());
        print(carInfo);
        carInstances.add(carInfo);
      }
    });

    return carInstances;
  }

  static Future<List<CarInfoModel>> getUuidCar(String UUID) async {
    List<CarInfoModel> carInstances = [];
    await fireStore
        .collection('CarINFO')
        .where("uuid", isEqualTo: UUID)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        carInfo = CarInfoModel.fromJson(doc.reference.id, doc.data());
        print(carInfo);
        carInstances.add(carInfo);
      }
    });

    return carInstances;
  }

  static Future<int> createData(
      Map<String, dynamic> carInfo, List<XFile> images) async {
    Reference imgRef;
    late String docID;
    bool check = false;

    await fireStore.collection('CarINFO').add(carInfo).then(
          (value) => {
            check = true,
            docID = value.id,
          },
        );
    imgRef = fireStorage.ref().child('carIMG/${carInfo['uuid']}/');
    for (int i = 0; i < images.length; i++) {
      imgRef.child('$docID/$i.jpg').putFile(File(images[i].path));
    }
    if (check) {
      return 0;
    }
    return 1;
  }
}
