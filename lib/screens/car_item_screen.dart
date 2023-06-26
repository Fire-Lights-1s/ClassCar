import 'package:carousel_slider/carousel_slider.dart';
import 'package:classcar/screens/car_data_upgrade.dart';
import 'package:flutter/material.dart';
import '../widgets/underbar_icon.dart';

class CarDetailScreen extends StatefulWidget {
  final String carName;

  const CarDetailScreen({
    super.key,
    required this.carName,
  });

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  int _currentImgIdx = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> conList = [
    Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
    ),
  ];

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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  imgSlider(),
                  imgIndicator(),
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
                        NameValue(name: "모델", value: widget.carName),
                        NameValue(name: "차량번호", value: widget.carName),
                        NameValue(name: "차종", value: widget.carName),
                        NameValue(name: "연료", value: widget.carName),
                        NameValue(name: "연비", value: widget.carName),
                        NameValue(name: "승차인원", value: widget.carName),
                        NameValue(name: "제조사", value: widget.carName),
                        NameValue(name: "구동방식", value: widget.carName),
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
                        NameValue(name: "평점", value: widget.carName),
                        NameValue(name: "대여횟수", value: widget.carName),
                        const NameContent(
                            name: "기타사항",
                            content: "기타사항 내용 기타사항 내용 기타사항 내용 기타사항 내용 기타사항 내용"),
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
                      children: [
                        NameValue(name: "모델", value: widget.carName),
                        NameValue(name: "차량번호", value: widget.carName),
                        NameValue(name: "차종", value: widget.carName),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      CarDataUpgrade(
                                        carName: widget.carName,
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
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
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

  Widget imgIndicator() {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: conList.asMap().entries.map(
          (entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withAlpha(_currentImgIdx == entry.key ? 200 : 50),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget imgSlider() {
    return CarouselSlider(
      items: conList.map(
        (img) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: img,
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _currentImgIdx = index;
          });
        },
      ),
    );
  }
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
