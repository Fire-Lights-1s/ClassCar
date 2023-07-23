class CarInfoModel {
  late String userId;
  late double carGasMil;
  late String carLocation;
  late String carModel;
  late String carNumber;
  late String carPicture;
  late String carType;
  late String description;
  late Map<String, dynamic> insideOption;
  late bool isExhibit;
  late String maker;
  late String oilType;
  late Map<String, dynamic> safeOption;
  late int seats;
  late Map<String, dynamic> usabilityOption;
  late int years;

  CarInfoModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        carGasMil = json['carGasMil'],
        carLocation = json['carLocation'],
        carModel = json['carModel'],
        carNumber = json['carNumber'],
        carPicture = json['carPicture'],
        carType = json['carType'],
        description = json['description'],
        insideOption = json['insideOption'],
        isExhibit = json['isExhibit'],
        maker = json['maker'],
        oilType = json['oilType'],
        safeOption = json['safeOption'],
        seats = json['seats'],
        usabilityOption = json['usabilityOption'],
        years = json['years'];
}
