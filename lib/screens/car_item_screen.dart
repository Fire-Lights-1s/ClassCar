import 'package:carousel_slider/carousel_slider.dart';
import 'package:classcar/Api/car_DB_connector.dart';
import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/screens/car_info_update.dart';
import 'package:classcar/widgets/car_item_delete.dart';
import 'package:classcar/widgets/img_slider.dart';
import 'package:flutter/material.dart';

class CarDetailScreen extends StatefulWidget {
  final String documentID;
  final CarInfoModel carModel;

  const CarDetailScreen({
    super.key,
    required this.documentID,
    required this.carModel,
  });

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  int _currentImgIdx = 0;
  final CarouselController _controller = CarouselController();
  late String carLoc = widget.carModel.carLocation;
  late bool isExhibit = widget.carModel.isExhibit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '차량 관리',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: OutlinedButton(
              onPressed: () async {
                isExhibit = await CarDataConnector.fieldUpdate(
                  docID: widget.carModel.docID,
                  field: 'isExhibit',
                  value: !isExhibit,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(isExhibit
                    ? const Color.fromARGB(255, 255, 223, 129)
                    : Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Colors.amber,
                    width: 2,
                  ),
                ),
              ),
              child: isExhibit
                  ? const Text(
                      "ON",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  : const Text(
                      "OFF",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  ImgSlider(
                    imgURL: widget.carModel.carImgURL!,
                    onChanged: (index) {
                      _currentImgIdx = index;
                      setState(() {});
                    },
                  ),
                  ImgIndicator(
                    imgURL: widget.carModel.carImgURL!,
                    controller: _controller,
                    currentImgIdx: _currentImgIdx,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xffE7E7E7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "기본 정보",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(color: Color(0xffD1E4FF)),
                    child: Column(
                      children: [
                        NameValue(name: "모델", value: widget.carModel.carModel),
                        NameValue(
                            name: "차량번호", value: widget.carModel.carNumber),
                        NameValue(name: "차종", value: widget.carModel.carType),
                        NameValue(name: "연료", value: widget.carModel.oilType),
                        NameValue(
                            name: "연비",
                            value: widget.carModel.carGasMil.toString()),
                        NameValue(
                            name: "승차인원",
                            value: widget.carModel.seats.toString()),
                        NameValue(name: "제조사", value: widget.carModel.maker),
                        NameContent(
                          name: "차량 위치",
                          content: carLoc.replaceAllMapped(
                            '/',
                            (match) {
                              return '\n';
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ClassCar 정보",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(color: Color(0xffD1E4FF)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NameValue(
                            name: "평점",
                            value: widget.carModel.score.toString()),
                        NameValue(
                            name: "대여횟수",
                            value: widget.carModel.sharedCount.toString()),
                        NameContent(
                            name: "기타사항", content: widget.carModel.description),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "옵션 정보",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(color: Color(0xffD1E4FF)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        OptionValue(
                          name: "내장",
                          optionsList: widget.carModel.insideOption,
                        ),
                        OptionValue(
                          name: "안전",
                          optionsList: widget.carModel.safeOption,
                        ),
                        OptionValue(
                          name: "편의",
                          optionsList: widget.carModel.usabilityOption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      CarDataUpdate(
                                        carModel: widget.carModel,
                                        documentID: widget.documentID,
                                      )),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff74B2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "수정하기",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CarItemDeleteDialog(
                                  carModel: widget.carModel,
                                  title: '삭제하시겠습니까?',
                                  onClick: (value) {
                                    if (value == '삭제') {
                                      Navigator.pop(context);
                                    } else if (value == '취소') {}
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 2, color: Color(0xFF003257)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            "삭제하기",
                            style: TextStyle(
                                color: Color(0xFF003257), fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
}

class NameValue extends StatelessWidget {
  const NameValue({
    super.key,
    required this.name,
    required this.value,
  });

  final String name, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CarInfoText(text: name),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CarInfoText(text: value),
          ),
        ],
      ),
    );
  }
}

class OptionValue extends StatelessWidget {
  const OptionValue({
    super.key,
    required this.name,
    required this.optionsList,
  });

  final String name;
  final Map<String, dynamic> optionsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: CarInfoText(text: name),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (String key in optionsList.keys.toList()) ...[
                  if (optionsList[key]) CarInfoText(text: key),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NameContent extends StatelessWidget {
  const NameContent({
    super.key,
    required this.name,
    required this.content,
  });

  final String name, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarInfoText(text: name),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CarInfoText(text: content),
        ),
      ],
    );
  }
}

class CarInfoText extends StatelessWidget {
  final String text;

  const CarInfoText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
