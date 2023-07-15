import 'package:classcar/screens/mywallet_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(67),
        child: AppBar(
          //앱바 로고
          backgroundColor: const Color(0xFF74B2F2),
          title: const Text('Icon space'),
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
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 50,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
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
                                '요청 내역',
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
                                Icons.phone_iphone_rounded,
                                size: 80,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyWalletScreen()));
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
