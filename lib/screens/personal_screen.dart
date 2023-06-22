import 'package:classcar/Api/widget.dart';
import 'package:classcar/screens/main_screen.dart';
import 'package:flutter/material.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onConsoleMessage: (_, message) => print(message),
      onLoadError: (controller, uri, errorCode, message) => setState(
        () {
          _isError = true;
          errorMessage = message;
        },
      ),
      onLoadHttpError: (controller, uri, errorCode, message) => setState(
        () {
          _isError = true;
          errorMessage = message;
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
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
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '개인정보입력',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    //아이디 입력칸
                    const Text(
                      '아이디',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '아이디 입력',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),

                    //비밀번호 입력칸
                    const Text(
                      '비밀번호',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '비밀번호를 입력해주세요',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //이메일 입력칸
                    const Text(
                      '이메일',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '예) Hongildong123@gmail.com',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //이름 입력칸
                    const Text(
                      '이름',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '예) 홍길동',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //생년월일 입력칸
                    const Text(
                      '생년월일',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '예) 950101',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // 주소검색 적용부분
                    const Text(
                      '거주위치',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F1FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => daumPostcodeSearch));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '주소를 입력하세요',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const Icon(Icons.search_rounded),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isError,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(errorMessage ?? ""),
                          ElevatedButton(
                            child: const Text("Refresh"),
                            onPressed: () {
                              daumPostcodeSearch.controller?.reload();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: Container(
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFF74B2F2),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF9FBFF),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFD0D0D0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      bottom: 31,
                    ),
                    child: Text(
                      '인증완료',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
