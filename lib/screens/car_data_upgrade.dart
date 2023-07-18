import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Api/daum_post_screen_view.dart';

class CarDataUpgrade extends StatefulWidget {
  final String carName;

  const CarDataUpgrade({
    super.key,
    required this.carName,
  });

  @override
  State<CarDataUpgrade> createState() => _CarDataUpgradeState();
}

class _CarDataUpgradeState extends State<CarDataUpgrade> {
  late TextEditingController carNameTF,
      carNumTF,
      carLocTF,
      carCasTF,
      carSeatsTF,
      carMakerTF;
  String _selctCas = '휘발유-가솔린';
  final List<String> _casList = [
    '휘발유-가솔린',
    '경유-디젤',
    '천연가스-CNG',
    '액화석유가스-LPG',
    '전기-EV',
    '수소전기-FCEV',
  ];
  String _selctCarTpye = '소형차';
  final List<String> _carTpye = [
    '소형차',
    '중형차',
    '대형차',
  ];

  DataModel? _dataModel;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carNameTF = TextEditingController(text: "${widget.carName} 기종 값");
    carNumTF = TextEditingController(text: "번호 값");
    carLocTF = TextEditingController(text: "차량 위치 값");
    carCasTF = TextEditingController(text: '연비 값');
    carSeatsTF = TextEditingController(text: '승차인원 값');
    carMakerTF = TextEditingController(text: '제조사 현대');
  }

  @override
  Widget build(BuildContext context) {
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
              CarInfoInput(
                maxLength: 20,
                fractionationInfo: '차량기종',
                hintText: '차량 기종(모델명)',
                textControll: carNameTF,
              ),
              CarInfoInput(
                maxLength: 10,
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
                          flex: 1,
                          fit: FlexFit.tight,
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
                                  horizontal: 15.0, vertical: 7),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                dropdownColor: const Color(0xFFE9F1FF),
                                value: _selctCas,
                                items: _casList.map(
                                  (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selctCas = value.toString();
                                  });
                                },
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
                            maxLength: 5,
                            textfiledController: carCasTF,
                            hintText: '연비를 입력해주세요',
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
                      "차량 종류/ 제조사/ 승차인원",
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
                                  horizontal: 15.0, vertical: 7),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                dropdownColor: const Color(0xFFE9F1FF),
                                value: _selctCarTpye,
                                items: _carTpye.map(
                                  (value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selctCarTpye = value.toString();
                                  });
                                },
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
                            hintText: '제조사을 입력해주세요',
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
                            hintText: '승차인원을 입력해주세요',
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
              TextButton(
                onPressed: () {
                  print(carNameTF.text);
                },
                child: const Text('test'),
              )
            ],
          ),
        ),
      ),
    );
  }

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
              })).then((value) {
                if (value != null) {
                  setState(() {
                    _dataModel = value;
                  });
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
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 15),
                child: Center(
                  child: Row(
                    children: [
                      if (_dataModel != null) ...[
                        Expanded(
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
                      ],
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
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormFieldDecoration extends StatelessWidget {
  final TextEditingController textfiledController;
  final String hintText;
  final int maxLength;

  const TextFormFieldDecoration({
    super.key,
    required this.textfiledController,
    required this.hintText,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textfiledController,
      maxLength: maxLength,
      keyboardType: TextInputType.text,
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
