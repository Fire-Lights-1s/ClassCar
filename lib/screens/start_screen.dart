import 'package:classcar/screens/join_main_screen.dart';

import 'login_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
  });

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 8,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/car.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: const Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    '여러분과 함께하는',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '클래스카',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE3A72F),
                      ),
                      child: const Center(
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JoinMainScreen()));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                      child: const Center(
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
