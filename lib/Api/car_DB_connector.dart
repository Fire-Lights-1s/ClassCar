import 'dart:io';

import 'package:classcar/module/car_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CarDataConnector {
  static final fireStore = FirebaseFirestore.instance;
  static final fireStorage = FirebaseStorage.instance;
  static var carInfo;

// 차량 컬렉션의 모든 차량 정보를 가져옴
  static Future<List<CarInfoModel>> getData() async {
    List<CarInfoModel> carInstances = [];
    await fireStore.collection('Car').get().then((event) {
      for (var doc in event.docs) {
        carInfo = CarInfoModel.fromJson(doc.reference.id, doc.data());
        carInstances.add(carInfo);
      }
    });

    return carInstances;
  }

// 차량 컬렉션의 특정 유저의 차량 정보를 가져옴
  static Future<List<CarInfoModel>> getUuidCar(String UUID) async {
    List<CarInfoModel> carInstances = [];
    await fireStore
        .collection('Car')
        .where("uuid", isEqualTo: UUID)
        .where('carExist', isEqualTo: true)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        carInfo = CarInfoModel.fromJson(doc.reference.id, doc.data());
        carInstances.add(carInfo);
      }
    });

    return carInstances;
  }

  //차량 docId로 차량 정보 가져오기
  static Future<List<CarInfoModel>> getCarDocId(String carDocId) async {
    List<CarInfoModel> carInstances = [];
    await fireStore.collection('Car').doc(carDocId).get().then((value) {
      carInstances.add(CarInfoModel.fromJson(carDocId, value.data()!));
    });
    return carInstances;
  }

  static Future<Stream<QuerySnapshot>> getUuidCarStream(String UUID) async {
    return fireStore
        .collection('Car')
        .where("uuid", isEqualTo: UUID)
        .where('carExist', isEqualTo: true)
        .snapshots();
  }

  static Future<List<String>> getcarImg(String userUid, String carUid) async {
    List<String> imgList = [];
    ListResult result = await FirebaseStorage.instance
        .ref("carIMG/$userUid/$carUid/")
        .listAll();
    for (final e in result.items) {
      imgList.add(await e.getDownloadURL());
    }
    return imgList;
  }

  static Future<int> createData(
      Map<String, dynamic> carInfo, List<XFile> images) async {
    Reference imgRef;
    late String docID;
    List<String> imgURL = [];

    await fireStore.collection('Car').add(carInfo).then(
      (value) => {
        docID = value.id,
      },
      onError: (e) {
        return 1;
      },
    );

    imgRef = fireStorage.ref().child('carIMG/${carInfo['uuid']}/$docID/');

    for (int i = 0; i < images.length; i++) {
      await imgRef.child('$i.jpg').putFile(File(images[i].path));
      imgURL.add(await imgRef.child('$i.jpg').getDownloadURL());
    }
    await fireStore
        .collection('Car')
        .doc(docID)
        .update({'carImgURL': imgURL}).then(
      (value) {},
      onError: (e) {
        return 1;
      },
    );

    return 0;
  }

  static updateData(CarInfoModel updateData, List<XFile>? images) async {
    Reference imgRef;
    List<String> imgURL = [];

    if (images!.isNotEmpty) {
      imgRef = fireStorage
          .ref()
          .child('carIMG/${updateData.uuid}/${updateData.docID}/');
      // 경로의 이미지를 전부 삭제
      imgRef.listAll().then(
        (res) => {
          res.items.forEach((file) async {
            fireStorage.ref(file.fullPath).delete();
          })
        },
        onError: (e) {
          return 1;
        },
      );
      // 새로 받은 이미지를 경로에 추가
      for (int i = 0; i < images.length; i++) {
        await imgRef.child('$i.jpg').putFile(File(images[i].path));
        imgURL.add(await imgRef.child('$i.jpg').getDownloadURL());
      }
      updateData.carImgURL = imgURL;
      // fireStore에 등록
      await fireStore
          .collection('Car')
          .doc(updateData.docID)
          .update(updateData.getUpdateMap())
          .then(
        (value) => {},
        onError: (e) {
          return 1;
        },
      );
    } else {
      // fireStore에 등록
      await fireStore
          .collection('Car')
          .doc(updateData.docID)
          .update(updateData.getUpdateMap())
          .then(
        (value) => {},
        onError: (e) {
          return 1;
        },
      );
    }
    return 0;
  }

  // 특정 필드 수정
  static fieldUpdate({
    required String docID,
    required String field,
    dynamic value,
  }) async {
    await fireStore.collection('Car').doc(docID).update({field: value});
    return value;
  }

  // 차량 관련 데이터 삭제
  static carDocumentDelete({
    required String UUID,
    required String CarUID,
  }) async {
    // 차량 데이터를 완전히 삭제하지 않고 보여주지만 않게 만듬
    await fireStore
        .collection('Car')
        .doc(CarUID)
        .update({'carExist': false, 'isExhibit': false});

    //Reference imgRef;
    //imgRef = fireStorage.ref().child('carIMG/$UUID/$CarUID/');

    // 경로의 이미지를 전부 삭제
    // imgRef.listAll().then((res) => {
    //       res.items.forEach((file) async {
    //         fireStorage.ref(file.fullPath).delete();
    //       })
    //     });
    // fireStore.collection('Car').doc(CarUID).delete().then(
    //       (doc) => print("Document deleted"),
    //       onError: (e) => print("Error updating document $e"),
    //     );
  }

  static test(CarInfoModel updateData, List<XFile>? images) async {
    Reference imgRef;
    imgRef = fireStorage
        .ref()
        .child('carIMG/${updateData.uuid}/${updateData.docID}/');
    imgRef.listAll().then((res) => {
          res.items.forEach((file) async {
            print(file.fullPath);
          })
        });
  }
}
