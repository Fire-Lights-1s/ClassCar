import 'package:cloud_firestore/cloud_firestore.dart';

class CarInfoModel {
  //차량 컬렉션에 차량의 문서 uid 받음
  late String docID;
  // uuid로 차량 이미지를 불러올 것임
  late String uuid;
  // 차량의 공개 여부 설정
  late bool isExhibit;
  // 차량의 사용 중인지 표시하는 필드
  late bool carState;
  // 차량 연비
  late double carGasMil;
  // 차량 주소 / 상세 주소 형태로 저장
  late String carLocation;
  // 차량 모델
  late String carModel;
  // 차량 번호
  late String carNumber;
  // 차량 유현( 소형차, 중형차, ... 등)
  late String carType;
  // 차량 제조사
  late String maker;
  // 사용하는 연료
  late String oilType;
  // 좌석
  late int seats;
  // 연식 제조 년도를 저장
  late String years;
  // 문서 생성 일
  late Timestamp? createdAt;
  // 환불 기간
  late String? cancelPolicyDate;
  //환불 퍼센트
  late String? cancelPolicyPercent;
  late int? score;
  late int? sharedCount;
  late int? sharingPrice;
  late String description;
  // 옵션
  late Map<String, dynamic> insideOption;
  late Map<String, dynamic> safeOption;
  late Map<String, dynamic> usabilityOption;

  CarInfoModel.fromJson(String documentID, Map<String, dynamic> json)
      : docID = documentID,
        uuid = json['uuid'],
        isExhibit = json['isExhibit'],
        carState = json['carState'],
        carGasMil = json['carGasMil'],
        carLocation = json['carLocation'],
        carModel = json['carModel'],
        carNumber = json['carNumber'],
        carType = json['carType'],
        maker = json['maker'],
        oilType = json['oilType'],
        seats = json['seats'],
        years = json['years'],
        createdAt = json['createdAt'],
        cancelPolicyDate = json['cancelPolicyDate'],
        cancelPolicyPercent = json['cancelPolicyPercent'],
        score = json['score'],
        sharedCount = json['sharedCount'],
        sharingPrice = json['sharingPrice'],
        description = json['description'],
        safeOption = json['safeOption'],
        insideOption = json['insideOption'],
        usabilityOption = json['usabilityOption'];
}
