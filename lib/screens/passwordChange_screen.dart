import 'package:classcar/module/user_info_model.dart';
import 'package:classcar/module/user_model.dart';
import 'package:flutter/material.dart';

class PasswordChangeScreen extends StatelessWidget {
  late String passwordChange;
  final String documentID;
  PasswordChangeScreen({
    super.key,
    required this.documentID,
  });

  var nowPasswordController = TextEditingController();
  var changePasswordController = TextEditingController();
  var passwordCheckController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 변경',
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                      ),
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: nowPasswordController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Color(0xFFE9F1FF),
                          hintText: '현재 비밀번호 입력',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                      ),
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: changePasswordController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Color(0xFFE9F1FF),
                          hintText: '새 비밀번호 입력',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                      ),
                      padding: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: passwordCheckController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Color(0xFFE9F1FF),
                          hintText: '새 비밀번호 입력 확인',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final UserInfoModel userData =
                              await UserInfoUpdate.getUser(documentID);
                          if (nowPasswordController.text == userData.passWord) {
                            //입력한 데이터값을 updateData로 넘겨야함
                            if (changePasswordController.text ==
                                passwordCheckController.text) {
                              passwordChange = changePasswordController.text;
                              UserInfoUpdate.updataData(
                                  passwordChange, documentID);
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20,
                            bottom: 20,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD0D0D0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '비밀번호 변경',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }
}
