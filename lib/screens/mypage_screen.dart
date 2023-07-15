import 'package:classcar/screens/login_screen.dart';
import 'package:classcar/screens/mywallet_screen.dart';
import 'package:classcar/screens/notice_screen.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3A72F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 65,
            ),
            // 프로필부분
            const Profile(),
            const SizedBox(
              height: 20,
            ),

            //회색 배경 컨테이너
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          // 내 지갑 버튼
                          Flexible(
                            flex: 1,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyWalletScreen()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '내 지갑',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                '35,000원',
                                                style: TextStyle(
                                                  color: Color(0xFF74B2F2),
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: Icon(Icons.money_rounded, size: 60),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),

                          //차량 관리 버튼
                          Flexible(
                            flex: 1,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '차량확인',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              '미 운행중',
                                              style: TextStyle(
                                                color: Color(0xFF74B2F2),
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child:
                                      Icon(Icons.drive_eta_rounded, size: 60),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // 공지사항 버튼
                        Flexible(
                          flex: 1,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NoticeScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '공지사항',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              '텍스트 없음',
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: 10,
                                bottom: 0,
                                child:
                                    Icon(Icons.announcement_outlined, size: 60),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        //1대1 상담버튼
                        Flexible(
                          flex: 1,
                          child: Stack(
                            children: [
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1:1 상담',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              '텍스트 없음',
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: 10,
                                bottom: 0,
                                child:
                                    Icon(Icons.support_agent_rounded, size: 60),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //설정
                    const Row(
                      children: [
                        Text(
                          '설정',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                    Icons.notifications_active_outlined,
                                    size: 45),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  '알림',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                      Icons.arrow_forward_ios_rounded)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Icon(Icons.lock_open, size: 45),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  '비밀번호 변경',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                      Icons.arrow_forward_ios_rounded)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 80,
          ),
          Text(
            '홍길동',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'abcdefg@gmail.com',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB3B3B3),
            ),
          ),
        ],
      ),
    );
  }
}
