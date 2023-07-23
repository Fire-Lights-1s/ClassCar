import 'package:classcar/module/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoUpdate {
  static final firestore = FirebaseFirestore.instance;
  static var userIdInfo;

  static Future<List<UserInfoModel>> getData() async {
    List<UserInfoModel> userInstances = [];
    print('firebase 가져오기 시작');
    await firestore.collection('userINFO').get().then((event) {
      for (var doc in event.docs) {
        userIdInfo = UserInfoModel.fromJson(doc.data());
        userInstances.add(userIdInfo);
      }
    });

    return userInstances;
  }

  static Future<int> addData(Map<String, dynamic> userInfo) async {
    bool check = false;
    await firestore
        .collection('userINFO')
        .add(userInfo)
        .then((value) => {check = true});
    if (check) {
      return 0;
    }
    return 1;
  }
}
