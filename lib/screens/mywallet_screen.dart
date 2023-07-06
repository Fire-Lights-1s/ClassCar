import 'package:classcar/widgets/recent_list.dart';
import 'package:classcar/widgets/underbar_icon.dart';
import 'package:flutter/material.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  var _selectMain = '최근내역';
  final _selectList = [
    '최근내역',
    '최근 1개월',
    '최근 3개월',
    '최근 6개월',
    '최근 1년',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '내 지갑',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.description,
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.person_rounded,
                iconColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),

            //클라스카 페이 컨테이너 부분
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xFFE9F1FF),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: const Offset(2, 7),
                      ),
                    ]),
                child: Column(
                  children: [
                    //Classcar 와 은행표시 줄
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CLASSCAR PAY',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3A72F),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '은행 이름',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //잔액 표시 줄
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD0D0D0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '35,000 원',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    //출금하기, 계좌관리 버튼 줄
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFFD0D0D0),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: const Text(
                              '출금 하기',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF003257),
                            ),
                            child: const Text(
                              '계좌 관리',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),

            //회색 경계선 부분
            Container(
              width: double.infinity,
              height: 25,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
              ),
            ),
            const SizedBox(height: 20),

            //최근 내역 부분
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: DropdownButton(
                      underline: const SizedBox.shrink(),
                      dropdownColor: const Color(0xFFE9F1FF),
                      value: _selectMain,
                      items: _selectList.map(
                        (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectMain = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            // 내역 표시하는 부분
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  RecentList(
                    recentDate: "5.5",
                    carName: "차량A",
                    dateTime: "15:00 ~ 18:00",
                    pricePay: 15000,
                  ),
                  RecentList(
                    recentDate: "5.5",
                    carName: "차량A",
                    dateTime: "12:00 ~ 15:00",
                    pricePay: 15000,
                  ),
                  RecentList(
                    recentDate: "5.4",
                    carName: "차량B",
                    dateTime: "11:00 ~ 12:00",
                    pricePay: 5000,
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
