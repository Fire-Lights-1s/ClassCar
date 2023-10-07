import 'package:classcar/module/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInfoUpdate {
  static final firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void errorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0);
  }

  static Future<List<UserInfoModel>> getData() async {
    List<UserInfoModel> userInstances = [];

    //firestore 모든 유저 정보 가져오기
    await firestore.collection('OwnerInfo').get().then((event) {
      for (var doc in event.docs) {
        var userIdInfo = UserInfoModel.fromJson(doc.reference.id, doc.data());
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

  // 유저 정보 생성
  static addData(String OwnerUid, Map<String, dynamic> userInfo) async {
    try {
      await firestore
          .collection('OwnerInfo')
          .doc(OwnerUid)
          .set(userInfo)
          .then((value) => {});
    } catch (e) {
      print('유저정보 등록 실패');
    }
  }

  // 유저 auth에 등록 및 유저정보 등록
  static Future<bool> signUpUserCredential({
    required String email,
    required String password,
    required Map<String, dynamic> userInfo,
  }) async {
    try {
      // 이메일로 계정 생성
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //현재 로그인이 되어있는지 확인
      if (_auth.currentUser != null) {
        String uid = _auth.currentUser!.uid;
        //auth 현재 계정 등록한 유저 uid로 계정 정보 저장
        addData(uid, userInfo);
      } else {
        print('유저정보 등록 실패');
      }

      return true;
    } catch (e) {
      void errorToast(String message) {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            fontSize: 16.0);
      }

      switch (e.toString()) {
        case "email-already-in-use":
          errorToast("이미 사용중인 이메일입니다");

          break;
        case "invalid-email":
          errorToast("잘못된 이메일 형식입니다");
          break;
        case "operation-not-allowed":
          errorToast("사용할 수 없는 방식입니다");

          break;
        case "weak-password":
          errorToast("비밀번호 보안 수준이 너무 낮습니다");

          break;
        default:
          errorToast("알수없는 오류가 발생했습니다");
      }
      return false;
    }
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
