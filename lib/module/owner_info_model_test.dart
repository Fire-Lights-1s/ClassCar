class UserInfoModel {
  late String docID;
  late String name;
  // late String userId;
  // late String passWord;
  late String phoneNumber;
  late String email;
  late List<dynamic>? bankList;
  late String birthday;
  late String address;
  late String detailAddress;
  late bool isCheckedAgreement;
  late bool isCheckedAgreement2;
  late bool isCheckedAgreementAD;
  late String backNum;
  late String telecom;
  late String? profileUrl;
  late int? totalMoney;

  UserInfoModel.fromJson(String documentID, Map<String, dynamic> json)
      : docID = documentID,
        name = json['name'],
        // userId = json['userId'],
        // passWord = json['passWord'],
        telecom = json['telecom'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        bankList = json['bankList'],
        birthday = json['birthday'],
        backNum = json['backNum'],
        address = json['address'],
        detailAddress = json['detailAddress'],
        isCheckedAgreement = json['isCheckedAgreement'],
        isCheckedAgreement2 = json['isCheckedAgreement2'],
        isCheckedAgreementAD = json['isCheckedAgreementAD'],
        profileUrl = json['profileUrl'],
        totalMoney = json['totalMoney'];
}
