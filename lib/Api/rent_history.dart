import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class RentModel {
  late String documentID;
  late Timestamp ResultTime;
  late bool withdraw;
  //차량 이용내역 결과 문서 필드
  late Timestamp? RentalStartTime;
  late Timestamp? RentalEndTime;
  late int? RentalCost;
  late String? CarName;
  //출금내역 문서 필드
  late String? bank;
  late int? withdrawMoney;

  RentModel.fromJsonWithdraw(String documentID, Map<String, dynamic> json)
      : documentID = documentID,
        ResultTime = json['ResultTime'],
        withdraw = json['withdraw'],
        bank = json['bank'],
        withdrawMoney = json['withdrawMoney'];

  RentModel.fromJsonRequest(String documentID, Map<String, dynamic> json)
      : documentID = documentID,
        ResultTime = json['ResultTime'],
        withdraw = json['withdraw'],
        RentalStartTime = json['RentalStartTime'],
        RentalEndTime = json['RentalEndTime'],
        RentalCost = json['RentalCost'],
        CarName = json['CarName'];

  Future<void> fetchCarInfo(String CarUID) async {
    DocumentSnapshot carInfoSnapshot =
        await FirebaseFirestore.instance.collection('Car').doc(CarUID).get();
    if (carInfoSnapshot.exists) {
      var carInfoData = carInfoSnapshot.data() as Map<String, dynamic>;
      CarName = carInfoData['carModel'];
    }
  }
}

class RentHistory {
  static Future<List<RentModel>> rentHistoryList(String OwnerUID) async {
    List<RentModel> RentAccepts = [];
    await FirebaseFirestore.instance
        .collection('RentResult')
        .orderBy("ResultTime", descending: true)
        .where("OwnerUID", isEqualTo: OwnerUID)
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        if (!doc['withdraw']) {
          var rentAccept =
              RentModel.fromJsonRequest(doc.reference.id, doc.data());
          RentAccepts.add(rentAccept);
        } else if (doc['withdraw']) {
          var rentAccept =
              RentModel.fromJsonWithdraw(doc.reference.id, doc.data());
          RentAccepts.add(rentAccept);
        }
      }
    });
    return RentAccepts;
  }
}
