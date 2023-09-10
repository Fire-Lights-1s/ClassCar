import 'package:carousel_slider/carousel_controller.dart';
import 'package:classcar/screens/mywallet_screen.dart';
import 'package:classcar/widgets/img_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final String documentID;

  const HomeScreen({
    super.key,
    required this.documentID,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentImgIdx = 0;
  final CarouselController _controller = CarouselController();

  Future<List<dynamic>> getAdImg() async {
    List<dynamic> adImg = [];
    await FirebaseFirestore.instance.collection('Event').get().then((event) {
      for (var doc in event.docs) {
        adImg = doc.data()['eventImg'];
      }
    });
    print(adImg);
    return adImg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67),
        child: AppBar(
          //앱바 로고
          backgroundColor: const Color(0xFF74B2F2),
          title: Center(
            child: SvgPicture.asset(
              'assets/icons/Logo.svg',
              width: 55,
              height: 50,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            //상단 홍보 슬라이드 부분
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FutureBuilder(
                    future: getAdImg(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return const CircularProgressIndicator();
                      } else {
                        return Stack(
                          children: [
                            ImgSlider(
                              //출처 <a href="https://kr.freepik.com/free-vector/lovely-set-of-colorful-banners_3354722.htm#query=%EB%B0%B0%EB%84%88&position=5&from_view=search&track=sph">Freepik</a>
                              imgURL: snapshot.data!,
                              onChanged: (index) {
                                _currentImgIdx = index;
                                setState(() {});
                              },
                            ),
                            ImgIndicator(
                              imgURL: snapshot.data!,
                              controller: _controller,
                              currentImgIdx: _currentImgIdx,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //요청내역, 수익내역 버튼
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyWalletScreen(
                                    documentID: widget.documentID)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F1FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        child: const Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '수익 내역',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  size: 80,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
