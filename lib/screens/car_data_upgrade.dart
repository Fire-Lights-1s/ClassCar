import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Api/daum_post_screen_view.dart';
import '../widgets/underbar_icon.dart';

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
  late TextEditingController carNameTextfiled, carNumTextfiled, carLocTextfiled;
  final List<String> _casList = [
    '휘발유-가솔린',
    '경유-디젤',
    '천연가스-CNG',
    '액화석유가스-LPG',
    '전기-EV',
    '수소전기-FCEV',
  ];
  String _selctCas = '휘발유-가솔린';

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
    carNameTextfiled = TextEditingController(text: "${widget.carName} 기종 초기값");
    carNumTextfiled = TextEditingController(text: "번호 초기값");
    carLocTextfiled = TextEditingController(text: "차량 위치 초기값");
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
            children: [
              CarInfoInput(
                fractionationInfo: '차량기종',
                hintText: '차량 기종(모델명)',
                textControll: carNameTextfiled,
              ),
              CarInfoInput(
                fractionationInfo: '차량 번호',
                hintText: '차량 번호',
                textControll: carNumTextfiled,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "연료와 연비",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: const ShapeDecoration(
                            color: Color(0xFFE9F1FF),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
              CarInfoLocation(
                context: context,
                title: '차량 위치',
                textfiledController: carLocTextfiled,
              ),
              TextButton(
                onPressed: () {
                  print(carNameTextfiled.text);
                },
                child: const Text('test'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              UnderBarIcon(
                icon: Icons.home_rounded,
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.directions_car_rounded,
                iconColor: Colors.black,
              ),
              UnderBarIcon(
                icon: Icons.description,
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.person_rounded,
                iconColor: Colors.grey,
              ),
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
          TextFormField(
            controller: textfiledController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Color(0xFFE9F1FF),
              hintText: '차량 상세 위치를 입력해주세요',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
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

class CarInfoInput extends StatelessWidget {
  final String fractionationInfo, hintText;
  final TextEditingController textControll;

  const CarInfoInput({
    super.key,
    required this.fractionationInfo,
    required this.hintText,
    required this.textControll,
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
          TextFormField(
            controller: textControll,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
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
          ),
        ],
      ),
    );
  }
}

class CarLocationInput extends StatelessWidget {
  final String fractionationInfo, hintText;
  final TextEditingController textControll;

  const CarLocationInput({
    super.key,
    required this.fractionationInfo,
    required this.hintText,
    required this.textControll,
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
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F1FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Text("주소 api 이용해서 수정하도록 해야함"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textControll,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
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
          ),
        ],
      ),
    );
  }
}
