class UserInfoModel {
  late String docID;
  late String name;
  // 아이디 비밀번호는 auth를 사용할거라서 주석처리
  // late String userId;
  // late String passWord;
  late String email;
  late String phoneNumber;
  late List<dynamic>? bankList;
  late String birthday;
  late String address;
  late String detailAddress;
  // 약관동의
  late bool isCheckedAgreement;
  late bool isCheckedAgreement2;
  late bool isCheckedAgreementAD;
  //주민번호 뒷자리 성별 확인용인듯함
  late String backNum;
  // 통신사 정보인것 같은데 이정보는 입력 칸을 없애서 이부분도 지울까 고민 중
  late String telecom;
  late String? profileUrl;
  late int? totalMoney;

  UserInfoModel.fromJson(String documentID, Map<String, dynamic> json)
      : docID = documentID,
        name = json['name'],
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
