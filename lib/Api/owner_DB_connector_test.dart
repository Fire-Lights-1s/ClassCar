import 'dart:io';

import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/module/owner_info_model_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class OwnerDataConnector {
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

  static Future<List<OwerInfoModel>> getData() async {
    List<OwerInfoModel> userInstances = [];

    //firestore 모든 유저 정보 가져오기
    await firestore.collection('OwnerInfoTest').get().then((event) {
      for (var doc in event.docs) {
        var userIdInfo = OwerInfoModel.fromJson(doc.reference.id, doc.data());
        userInstances.add(userIdInfo);
      }
    });

    return userInstances;
  }

  // 유저 정보 생성
  static addData(String OwnerUid, Map<String, dynamic> userInfo) async {
    try {
      await firestore
          .collection('OwnerInfoTest')
          .add(userInfo)
          .then((value) => {});
    } catch (e) {
      print('유저정보 등록 실패');
    }
  }

  // 유저 auth에 등록 및 유저정보 등록
  Future<bool> signUpUserCredential({
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
}
