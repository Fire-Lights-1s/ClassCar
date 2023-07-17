class UserInfoModel {
  late String name;
  late String userId;
  late String passWord;
  late String phoneNumber;
  late String email;
  late List<dynamic>? bankList;
  late String birthday;
  late String address;
  late bool isCheckedAgreement;
  late bool isCheckedAgreementAD;

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['userId'],
        passWord = json['passWord'],
        phoneNumber = json['phoneNumber'],
        email = json['email'],
        bankList = json['bankList'],
        birthday = json['birthday'],
        address = json['address'],
        isCheckedAgreement = json['isCheckedAgreement'],
        isCheckedAgreementAD = json['isCheckedAgreementAD'];
}
