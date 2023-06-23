import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

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
                    top: 70,
                    bottom: 70,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //차량 관리 버튼
            SizedBox(
              width: double.infinity,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
