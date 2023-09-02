import 'package:image_picker/image_picker.dart';

class CarInfoStateControll {
  String selctGas;
  List<String> gasList;
  String selctCarTpye;
  List<String> carTpye;
  late DateTime selectedDate;
  Map<String, dynamic> carInsideOption;
  Map<String, dynamic> carSafeOption;
  Map<String, dynamic> carUsabilityOption;
  //이미지 저장 위치
  List<XFile> pickedImgs = [];

  CarInfoStateControll.format()
      : selctGas = '휘발유-가솔린',
        gasList = [
          '휘발유-가솔린',
          '경유-디젤',
          '천연가스-CNG',
          '액화석유가스-LPG',
          '전기-EV',
          '수소전기-FCEV',
        ],
        selctCarTpye = '소형차',
        carTpye = [
          '소형차',
          '중형차',
          '대형차',
        ],
        selectedDate = DateTime.now(),
        carInsideOption = {
          '가죽시트': false,
          '열선시트': false,
          '통풍시트': false,
          '블랙박스': false,
        },
        carSafeOption = {
          '긴급제동시스템': false,
          '에어백': false,
          '후방감지센서': false,
          '후방카메라': false,
        },
        carUsabilityOption = {
          'AV시스템': false,
          'USB단자': false,
          '네비게이션': false,
          '블루투스': false,
          '하이패스': false,
        };
}
