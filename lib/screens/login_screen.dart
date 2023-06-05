import 'package:classcar/screens/join_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Row(
                children: [
                  Text(
                    '클라스카',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 52,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 4.0,
                        ),
                      ),
                      labelText: '아이디를 입력하세요',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 4.0,
                        ),
                      ),
                      labelText: '비밀번호를 입력하세요',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '비밀번호를 잊으셨나요?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E7ACC),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JoinScreen()));
                    },
                    child: Container(
                      width: 400,
                      height: 75,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD0D0D0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          color: Color(0xFF49483C),
                          fontSize: 28,
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
