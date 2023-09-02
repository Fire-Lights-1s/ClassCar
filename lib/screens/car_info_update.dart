import 'dart:convert';
import 'dart:io';

import 'package:classcar/Api/car_DB_connector.dart';
import 'package:classcar/module/car_data_state_controll.dart';
import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/screens/login_screen.dart';
import 'package:classcar/widgets/check_box_dialog.dart';
import 'package:classcar/widgets/year_picker_dialog.dart';
import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

import '../Api/daum_post_screen_view.dart';

class CarDataUpdate extends StatefulWidget {
  final String documentID;
  final CarInfoModel carModel;

  const CarDataUpdate({
    super.key,
    required this.documentID,
    required this.carModel,
  });

  @override
  State<CarDataUpdate> createState() => _CarDataUpdate();
}

class _CarDataUpdate extends State<CarDataUpdate> {
  // 현재 페이지 텍스트 필드 관리 변수
  late TextEditingController carNameTF,
      carNumTF,
      carLocTF,
      carGasTF,
      carSeatsTF,
      carMakerTF,
      carDescriptionTF;
  // 현재 페이지 옵션 값 & 선택하는 값 관리 변수 모음
  final _carState = CarInfoStateControll.format();
  late List<String> carLocation = widget.carModel.carLocation.split('/');
  late List<dynamic> carImgURL = widget.carModel.carImgURL!;
  //이미지 관련 변수 함수
  bool imgCheck = false;
  final ImagePicker carPicker = ImagePicker();

  Future<void> _PickImg() async {
    final List<XFile> images = await carPicker.pickMultiImage();
    if (images.isNotEmpty) {
      imgCheck = true;
    }
    if (images.length > 6) {
      _carState.pickedImgs = images.sublist(0, 6);
      // 토스트로 사용한 이미지 수를 표시해줘야함
      showToast("6장의 이미지만 사용합니다.");
    } else {
      _carState.pickedImgs = images;
    }
    setState(() {});
  }

  late List<Widget> _imgBoxContents;
  // 옵션 선택 Text
  Text optionTextBuild(Map<String, dynamic> options) {
    final buffer = StringBuffer();
    late String result;
    for (var option in options.keys.toList()) {
      if (options[option]!) {
        buffer.write(' $option /');
      }
    }
    result = buffer.toString();
    buffer.clear();
    return Text(
      ' $result ',
      style: const TextStyle(fontSize: 18),
      overflow: TextOverflow.ellipsis,
    );
  }

  // 연도 선택 Dialog
  void selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return YearPickerDialog(
          selectedDate: _carState.selectedDate,
          selectYear: (value) {
            setState(() {
              _carState.selectedDate = value;
            });
          },
        );
      },
    );
  }

  // 옵션 선택 Dialog
  void selctCheckBox(
      context, String title, Map<String, dynamic> options) async {
    showDialog(
      context: context,
      builder: (context) {
        return CheckBoxDialog(
          title: title,
          options: options,
          onChanged: (value) {
            setState(() {});
          },
        );
      },
    );
  }

  // 차량 이미지 관련 함수
  // 지도 관련 변수 & 함수
  DataModel? _dataModel;
  late GoogleMapController mapController;
  var lat = 37.4267861;
  var lng = -122.0806032;
  List<Marker> mark = [];

  late final LatLng _center = LatLng(lat, lng);

  Future<Map<String, dynamic>?> loadLoc(String addrees) async {
    const String GMaps = 'AIzaSyDCx0q_CxVUpZ2Bq_JjlHAPNW2P1AoyRfM';
    //  주소로 좌표 구하기
    String gpsUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$addrees&key=$GMaps&language=ko';

    final responseGps = await http.get(Uri.parse(gpsUrl));
    Map<String, dynamic> location =
        jsonDecode(responseGps.body)['results'][0]['geometry']['location'];
    print(location);
    return location;
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    var loc = await loadLoc(carLocation[0]);
    lat = loc!['lat'];
    lng = loc['lng'];
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(lat, lng),
        zoom: 14.0,
      ),
    ));
    mark.add(Marker(
      markerId: const MarkerId("1"),
      draggable: true,
      position: LatLng(lat, lng),
    ));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carState.selctGas = widget.carModel.oilType;
    _carState.selctCarTpye = widget.carModel.carType;
    _carState.selectedDate = DateTime.utc(int.parse(widget.carModel.years));
    _carState.carInsideOption = widget.carModel.insideOption;
    _carState.carSafeOption = widget.carModel.safeOption;
    _carState.carUsabilityOption = widget.carModel.usabilityOption;
    carNameTF = TextEditingController(text: widget.carModel.carModel);
    carNumTF = TextEditingController(text: widget.carModel.carNumber);
    carGasTF =
        TextEditingController(text: widget.carModel.carGasMil.toString());
    carSeatsTF = TextEditingController(text: widget.carModel.seats.toString());
    carMakerTF = TextEditingController(text: widget.carModel.maker);
    carDescriptionTF = TextEditingController(text: widget.carModel.description);
    carLocTF = TextEditingController(text: carLocation[1]);
  }

  @override
  Widget build(BuildContext context) {
    _imgBoxContents = [
      SizedBox(
        width: 80,
        height: 80,
        child: IconButton(
          onPressed: () {
            _PickImg();
          },
          icon: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.grey,
              size: 40,
            ),
          ),
        ),
      ),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '차량정보 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: OutlinedButton(
                onPressed: () async {
                  bool check = false;
                  String showMessage = '';
                  if (carNameTF.text != '') {
                    widget.carModel.carModel = carNameTF.text;
                    check = true;
                  } else {
                    check = false;
                    showMessage = "차량 기종을 입력해주세요";
                  }
                  if (carNumTF.text != '') {
                    widget.carModel.carNumber = carNumTF.text;
                  } else if (check == true) {
                    check = false;
                    showMessage = "차량 번호를 입력해주세요";
                  }
                  if (carGasTF.text != '') {
                    widget.carModel.carGasMil = double.parse(carGasTF.text);
                  } else {
                    check = false;
                    showMessage = "연비를 입력해주세요";
                  }
                  if (carSeatsTF.text != '') {
                    widget.carModel.seats = int.parse(carSeatsTF.text);
                  } else if (check == true) {
                    check = false;
                    showMessage = "좌석을 입력해주세요";
                  }
                  if (carMakerTF.text != '') {
                    widget.carModel.maker = carMakerTF.text;
                  } else if (check == true) {
                    check = false;
                    showMessage = "제조사를 입력해주세요";
                  }
                  if (_dataModel != null) {
                    widget.carModel.carLocation =
                        '${_dataModel!.address}/${carLocTF.text}';
                  }
                  if (check == true) {
                    widget.carModel.oilType = _carState.selctGas;
                    widget.carModel.carType = _carState.selctCarTpye;
                    widget.carModel.years =
                        _carState.selectedDate.year.toString();
                    widget.carModel.insideOption = _carState.carInsideOption;
                    widget.carModel.safeOption = _carState.carSafeOption;
                    widget.carModel.usabilityOption =
                        _carState.carUsabilityOption;
                    widget.carModel.description = carDescriptionTF.text;
                  }
                  // 필요 입력사항 표시
                  if (imgCheck == false && widget.carModel.carImgURL!.isEmpty) {
                    Fluttertoast.showToast(msg: '이미지를 1장 이상 넣어주세요.');
                  } else if (check == false) {
                    Fluttertoast.showToast(msg: showMessage);
                  }
                  if (check == true) {
                    int updateResult = await CarDataConnector.updateData(
                        widget.carModel, _carState.pickedImgs);
                    if (updateResult == 0) {
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: '다시 수정 버튼을 눌러주세요');
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text(
                  "수정",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ))
        ],
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "차량 사진",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(
                            6,
                            (index) => DottedBorder(
                              color: Colors.grey,
                              dashPattern: const [6, 4],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20),
                              child: Container(
                                decoration: index <=
                                        _carState.pickedImgs.length - 1
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(_carState
                                                .pickedImgs[index].path),
                                          ),
                                        ),
                                      )
                                    : BoxDecoration(
                                        color: const Color(0xFFE9F1FF),
                                        borderRadius: BorderRadius.circular(20),
                                        image: _carState.pickedImgs.isEmpty &&
                                                index <= carImgURL.length - 1
                                            ? DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  carImgURL[index],
                                                ),
                                              )
                                            : null),
                                child: Center(child: _imgBoxContents[index]),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CarInfoInput(
                maxLength: 20,
                fractionationInfo: '차량기종',
                hintText: '차량 기종(모델명)',
                textControll: carNameTF,
              ),
              CarInfoInput(
                maxLength: 15,
                fractionationInfo: '차량 번호',
                hintText: '차량 번호',
                textControll: carNumTF,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "연료/ 연비",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: dropDownCarInfo(
                            list: _carState.gasList,
                            select: _carState.selctGas,
                            onTap: (value) {
                              setState(() {
                                _carState.selctGas = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormFieldDecoration(
                            maxLength: 5,
                            textfiledController: carGasTF,
                            hintText: '연비를 입력해주세요',
                            regExp: '[0-9|.]',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "차량 종류/ 승차인원",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: dropDownCarInfo(
                            list: _carState.carTpye,
                            select: _carState.selctCarTpye,
                            onTap: (value) {
                              setState(() {
                                _carState.selctCarTpye = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormFieldDecoration(
                            maxLength: 5,
                            textfiledController: carSeatsTF,
                            hintText: '승차인원',
                            regExp: '[0-9]',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "연식/ 제조사",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              selectYear(context);
                            },
                            child: DecoratedBox(
                              decoration: const ShapeDecoration(
                                color: Color(0xFFE9F1FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _carState.selectedDate.year.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(Icons.calendar_month_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormFieldDecoration(
                            maxLength: 10,
                            textfiledController: carMakerTF,
                            hintText: '제조사',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "내장/ 안전/ 편의 옵션",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    optionSelectBox(
                      context: context,
                      title: '내장 옵션',
                      options: _carState.carInsideOption,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    optionSelectBox(
                      context: context,
                      title: '안전 옵션',
                      options: _carState.carSafeOption,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    optionSelectBox(
                      context: context,
                      title: '편의 옵션',
                      options: _carState.carUsabilityOption,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "기타 사항",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormFieldDecoration(
                            maxLength: 250,
                            textfiledController: carDescriptionTF,
                            hintText: '기타입력값',
                            line: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CarInfoLocation(
                context: context,
                title: '차량 위치',
                textfiledController: carLocTF,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector optionSelectBox({
    required BuildContext context,
    required String title,
    required Map<String, dynamic> options,
  }) {
    return GestureDetector(
      onTap: () {
        selctCheckBox(context, title, options);
      },
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Color(0xFFE9F1FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: optionTextBuild(options),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DecoratedBox dropDownCarInfo({
    required List<String> list,
    required String select,
    required onTap(value),
  }) {
    return DecoratedBox(
      decoration: const ShapeDecoration(
        color: Color(0xFFE9F1FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return list
                .map((value) => PopupMenuItem(
                      value: value,
                      onTap: () {
                        onTap(value);
                      },
                      child: Text(value),
                    ))
                .toList();
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  select,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 주소와 지도를 보여주는 컨테이너
  Container CarInfoLocation({
    required BuildContext context,
    required TextEditingController textfiledController,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const LibraryDaumPostcodeScreen();
              })).then((value) async {
                if (value != null) {
                  _dataModel = await value;
                  setState(() {});
                  //주소로 위도,경도를 얻는 Geocode API
                  var loc = await loadLoc(_dataModel!.address);
                  lat = loc!['lat'];
                  lng = loc['lng'];
                  // 카메라 이동
                  mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target: LatLng(lat, lng),
                      zoom: 14.0,
                    ),
                  ));
                  mark.add(Marker(
                    markerId: const MarkerId("1"),
                    draggable: true,
                    position: LatLng(lat, lng),
                  ));
                  setState(() {});
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color(0xFFE9F1FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                child: Center(
                  child: Row(
                    children: [
                      _dataModel != null
                          ? Expanded(
                              flex: 4,
                              child: Text(
                                _dataModel!.address,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          : Expanded(
                              flex: 4,
                              child: Text(
                                carLocation[0],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                      const Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldDecoration(
            maxLength: 50,
            textfiledController: textfiledController,
            hintText: '차량 상세 위치를 입력해주세요',
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 300,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: GoogleMap(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                markers: Set.from(mark),
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 꾸며진 Text 입력 상자
class TextFormFieldDecoration extends StatelessWidget {
  final TextEditingController textfiledController;
  final String hintText;
  final int maxLength;
  //크기
  final int? line;
  // 입력 제한 조건
  final String? regExp;
  const TextFormFieldDecoration({
    super.key,
    required this.textfiledController,
    required this.hintText,
    required this.maxLength,
    this.regExp,
    this.line,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textfiledController,
      maxLength: maxLength,
      maxLines: line,
      inputFormatters: [
        if (regExp != null) ...[
          FilteringTextInputFormatter(
            RegExp(regExp!),
            allow: true,
          ),
        ] else ...[
          FilteringTextInputFormatter(
            RegExp('[a-z A-Z ㄱ-ㅎ|가-힣|.|·|：|/|+|-|*|~|!|@|#|%|^|&|(|)|_|<|>]'),
            allow: true,
          ),
        ]
      ],
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        counterText: '',
        border: InputBorder.none,
        filled: true,
        fillColor: const Color(0xFFE9F1FF),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class CarInfoInput extends StatelessWidget {
  final String fractionationInfo, hintText;
  final TextEditingController textControll;
  final int maxLength;

  const CarInfoInput({
    super.key,
    required this.fractionationInfo,
    required this.hintText,
    required this.textControll,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fractionationInfo,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldDecoration(
            maxLength: maxLength,
            textfiledController: textControll,
            hintText: hintText,
          ),
        ],
      ),
    );
  }
}
