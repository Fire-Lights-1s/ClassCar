import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestInfoModel {
  late Timestamp RentalStartTime;
  late Timestamp RentalEndTime;
  late String Name;
  late String Situation;
  late Timestamp RequestDate;
  late int RentalCost;
  late String PhoneNum;
  late String CarName;
  late String CarNum;
  late String SharePlaceName;
  late String ProfileUrl;
  late String OwnerUid;
  late String documentID;
  late String CarUID;
  late String DriverUID;

  RequestInfoModel.fromJson(String documentID, Map<String, dynamic> json)
      : documentID = documentID,
        RentalStartTime = json['RentalStartTime'],
        RentalEndTime = json['RentalEndTime'],
        Situation = json['Situation'],
        RequestDate = json['RequestDate'],
        RentalCost = json['RentalCost'],
        OwnerUid = json['OwnerUID'],
        CarUID = json['CarUID'],
        DriverUID = json['DriverUID'];

  Future<void> fetchCarInfo(String CarUID) async {
    DocumentSnapshot carInfoSnapshot =
        await FirebaseFirestore.instance.collection('Car').doc(CarUID).get();
    if (carInfoSnapshot.exists) {
      var carInfoData = carInfoSnapshot.data() as Map<String, dynamic>;
      CarName = carInfoData['carModel'];
      CarNum = carInfoData['carNumber'];
      SharePlaceName = carInfoData['carLocation'];
    }
  }

  Future<void> fetchDriverInfo(String DriverUID) async {
    DocumentSnapshot driverInfoSnapshot = await FirebaseFirestore.instance
        .collection('userINFO')
        .doc(DriverUID)
        .get();
    if (driverInfoSnapshot.exists) {
      var driverInfoData = driverInfoSnapshot.data() as Map<String, dynamic>;
      Name = driverInfoData['name'];
      PhoneNum = driverInfoData['phoneNumber'];
      ProfileUrl = driverInfoData['profilePicLinjk'];

      await _loadImage(ProfileUrl);
    }
  }

  Future<void> _loadImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref(imagePath);
    final url = await ref.getDownloadURL();
    ProfileUrl = url;
  }
  
}
