import 'package:classcar/module/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserInfoUpdate {
  static final firestore = FirebaseFirestore.instance;
  static var userIdInfo;

  static Future<List<UserInfoModel>> getData() async {
    List<UserInfoModel> userInstances = [];
    print('firebase 가져오기 시작');
    await firestore.collection('OwnerInfo').get().then((event) {
      for (var doc in event.docs) {
        userIdInfo = UserInfoModel.fromJson(doc.reference.id, doc.data());
        userInstances.add(userIdInfo);
      }
    });

    return userInstances;
  }

  static Future<UserInfoModel> getUser(String documentID) async {
    late UserInfoModel userinfo;
    await firestore.collection('OwnerInfo').doc(documentID).get().then((event) {
      userinfo = UserInfoModel.fromJson(event.reference.id, event.data()!);
    });
    return userinfo;
  }

  //유저 이름 리턴
  static Future<String> getName(String documentID) async {
    late UserInfoModel user;
    await firestore.collection('OwnerInfo').doc(documentID).get().then((event) {
      user = UserInfoModel.fromJson(event.reference.id, event.data()!);
    });
    return user.name;
  }

  //유저 이메일 리턴
  static Future<String> getEmail(String documentID) async {
    late UserInfoModel email;
    await firestore.collection('OwnerInfo').doc(documentID).get().then((event) {
      email = UserInfoModel.fromJson(event.reference.id, event.data()!);
    });
    return email.email;
  }

  static Future<int> addData(Map<String, dynamic> userInfo) async {
    bool check = false;
    await firestore
        .collection('OwnerInfo')
        .add(userInfo)
        .then((value) => {check = true});
    if (check) {
      return 0;
    }
    return 1;
  }

  static Future<int> updataData(
      String field, dynamic value, String documentID) async {
    await firestore
        .collection('OwnerInfo')
        .doc(documentID)
        .update({field: value}).then((event) {
      print('업데이트 성공!');
    });
    return 0;
  }

  static Future<int> setUserImage(
      String documentID, dynamic userUpdateProfileAddress) async {
    await firestore
        .collection('OwnerInfo')
        .doc(documentID)
        .update({'profileUrl': userUpdateProfileAddress}).then((value) {},
            onError: (e) => print(e));
    return 0;
  }

  static Future<int> updatePhoto(documentID) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user-profile/')
        .child(documentID + '.jpg');
    return 0;
  }
}
