import 'package:classcar/module/car_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarDataConnector {
  static final firestore = FirebaseFirestore.instance;
  static var carInfo;

  static Future<List<CarInfoModel>> getData() async {
    List<CarInfoModel> carInstances = [];
    await firestore.collection('CarINFO').get().then((event) {
      for (var doc in event.docs) {
        carInfo = CarInfoModel.fromJson(doc.reference.id, doc.data());
        print(carInfo);
        carInstances.add(carInfo);
      }
    });

    return carInstances;
  }

  createData() {}
}
