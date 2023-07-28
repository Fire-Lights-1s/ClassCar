import 'package:classcar/module/user_info_model.dart';
import 'package:classcar/module/user_model.dart';
import 'package:classcar/screens/join_screen.dart';
import 'package:classcar/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();

  final _passwordController = TextEditingController();

  final firestore = FirebaseFirestore.instance;

  bool userInfoChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //시작 간격의 Expanded 를 넣지않으면 Textfield 클릭시
          //하단에 30pixel 정도의 overflow 가 발생.
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 50,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Expanded(
              flex: 1,
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
          ),
          Expanded(flex: 4, child: Container()),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      // == null or isEmpty
                      return '아이디를 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      // == null or isEmpty
                      return '비밀번호를 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '비밀번호를 잊으셨나요?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JoinScreen()));
                      },
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E7ACC),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    final List<UserInfoModel> userData =
                        await UserInfoUpdate.getData();
                    for (int i = 0; i < userData.length; i++) {
                      if (_idController.text == userData[i].userId &&
                          _passwordController.text == userData[i].passWord) {
                        userInfoChecked = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MainScreen(documentID: userData[i].docID)));
                        break;
                      }
                    }
                    if (userInfoChecked == false) {
                      showToast('아이디 또는 비밀번호를 확인해주세요');
                    }
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: const Color(0xFFD0D0D0),
    fontSize: 18,
    textColor: Colors.black,
    gravity: ToastGravity.CENTER,
  );
}
