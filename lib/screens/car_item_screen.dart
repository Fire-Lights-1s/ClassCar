import 'package:carousel_slider/carousel_slider.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 0),
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
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Text(
                    widget.carName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
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

  Align imgIndicator() {
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
