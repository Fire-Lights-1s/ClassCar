import 'package:classcar/module/appNotification.dart';
import 'package:classcar/module/request_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'car_info_model.dart';

class RequestInfoUpdate {
  static final firestore = FirebaseFirestore.instance;
  static var requestInfo;
  static var carInfo;

  static Future<List<RequestInfoModel>> getData() async {
    List<RequestInfoModel> requestInstances = [];
    print('firebase 가져오기 시작');
    await firestore.collection('requestList').get().then((event) {
      for (var doc in event.docs) {
        requestInfo = RequestInfoModel.fromJson(doc.reference.id, doc.data());
        requestInstances.add(requestInfo);
      }
    });

    return requestInstances;
  }

  static Stream<List<RequestInfoModel>> getStreamData() {
    return firestore.collection('requestList').snapshots().map((snapshot) {
      List<RequestInfoModel> requestInstances = [];
      for (var doc in snapshot.docs) {
        requestInfo = RequestInfoModel.fromJson(doc.reference.id, doc.data());
        requestInstances.add(requestInfo);
      }
      return requestInstances;
    });
  }

  static Stream<List<RequestInfoModel>> getStreamDataUid(String OwnerUID) {
    return firestore.collection('Rent').snapshots().map((snapshot) {
      List<RequestInfoModel> requestInstances = [];
      for (var doc in snapshot.docs) {
        requestInfo = RequestInfoModel.fromJson(doc.reference.id, doc.data());
        requestInstances.add(requestInfo);
      }
      return requestInstances;
    });
  }

  static Stream<List<RequestInfoModel>> getStreamDataUid5(String OwnerUID) {
    DateTime currentTime = DateTime.now();
    DateTime oneWeekAgo = currentTime.subtract(const Duration(days: 8));

    return firestore
        .collection('Rent')
        .where("OwnerUID", isEqualTo: OwnerUID)
        .where("RentalEndTime",
            isGreaterThanOrEqualTo: Timestamp.fromDate(oneWeekAgo))
        .snapshots()
        .asyncMap((snapshot) async {
      List<RequestInfoModel> requestInstances = [];
      for (var doc in snapshot.docs) {
        var requestInfo =
            RequestInfoModel.fromJson(doc.reference.id, doc.data());
        await requestInfo.fetchCarInfo(doc['CarUID']);
        await requestInfo.fetchDriverInfo(doc['DriverUID']);
        requestInstances.add(requestInfo);
      }
      requestInstances.sort((a, b) => b.RequestDate.compareTo(a.RequestDate));
      FlutterLocalNotification.showNotification('요청내역 알림보냄');
      return requestInstances;
    });
  }

  static getCar(String CarUID) async {
    List<CarInfoModel> carInstances = [];
    await firestore.collection('Car').doc(CarUID).get().then((value) =>
        {carInstances.add(CarInfoModel.fromJson(value.id, value.data()!))});

    return carInstances;
  }

  static Future<void> updateRequestSituation(
      String documentID, String newStatus) async {
    await firestore.collection('Rent').doc(documentID).update({
      'Situation': newStatus,
    });
  }

  static Future<void> updateRequestSituationDriving() async {
    Timestamp currentTime = Timestamp.now();

    QuerySnapshot rentDocs = await FirebaseFirestore.instance
        .collection('Rent')
        .where('RentalStartTime', isLessThanOrEqualTo: currentTime)
        .where('Situation', isEqualTo: '수락')
        .get();

    for (QueryDocumentSnapshot doc in rentDocs.docs) {
      String documentID = doc.id;

      await FirebaseFirestore.instance
          .collection('Rent')
          .doc(documentID)
          .update({
        'Situation': '운행중',
      });
    }
  }

  static Future<void> updateRequestSituationDrivingComplete() async {
    Timestamp currentTime = Timestamp.now();

    QuerySnapshot rentDocs = await FirebaseFirestore.instance
        .collection('Rent')
        .where('RentalEndTime', isLessThan: currentTime)
        .where('Situation', whereIn: ['운행중', '수락']).get();

    for (QueryDocumentSnapshot doc in rentDocs.docs) {
      String documentID = doc.id;

      await FirebaseFirestore.instance
          .collection('Rent')
          .doc(documentID)
          .update({
        'Situation': '운행완료',
      });
    }
  }

  static Future<void> updateRequestSituationCancel() async {
    Timestamp currentTime = Timestamp.now();

    QuerySnapshot rentDocs = await FirebaseFirestore.instance
        .collection('Rent')
        .where('RentalStartTime', isLessThan: currentTime)
        .where('Situation', isEqualTo: '수락대기')
        .get();

    for (QueryDocumentSnapshot doc in rentDocs.docs) {
      String documentID = doc.id;

      await FirebaseFirestore.instance
          .collection('Rent')
          .doc(documentID)
          .update({
        'Situation': '취소',
      });
    }
  }
}
