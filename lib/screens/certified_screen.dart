import 'package:classcar/screens/login_screen.dart';
import 'package:classcar/screens/personal_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class CertifiedScreen extends StatefulWidget {
  late Map<String, dynamic> NBTN;
  CertifiedScreen({
    super.key,
    required this.NBTN,
  });

  @override
  State<CertifiedScreen> createState() => _CertifiedScreenState();
}

class _CertifiedScreenState extends State<CertifiedScreen> {
  var _selectedValue = '내국인';
  final _valueList = ['내국인', '외국인'];
  final _selectedValue2 = "SKT";
  final _valueList2 = [
    'SKT',
    'KT',
    'LGU+',
    '알뜰폰 SKT',
    '알뜰폰 KT',
    '알뜰폰 LGU+',
  ];

  var maskFormatter = MaskTextInputFormatter(
    mask: '###-####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  var privateFormatter =
      MaskTextInputFormatter(mask: '#', filter: {"#": RegExp(r'[0-4]')});

  bool obText = false;
  final bool _phoneTrue = false;
  bool requrestedAuth = false;
  bool authOk = false;

  String backNum = "";
  var userNameController = TextEditingController();
  var FirstBirthController = TextEditingController();
  var SecondBirthController = TextEditingController();

  var PhoneNumberController = TextEditingController();
  var otpController = TextEditingController();
  bool _codeSent = false;
  late String _verificationId;
  final _key = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomAppBar(
        child: Column(
          // MainAxisSize.min 이 있어야 BottomAppBar 에서 Column을 사용하며 최소값을 지정해
          // 아래에 지정할 수 있음.
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF74B2F2),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                widget.NBTN['name'] = userNameController.text;
                widget.NBTN['birthday'] = FirstBirthController.text;
                widget.NBTN['backNum'] = SecondBirthController.text;
                widget.NBTN['telecom'] = _selectedValue2;
                widget.NBTN['phoneNumber'] = PhoneNumberController.text;

                if (userNameController.text.isNotEmpty &&
                    FirstBirthController.text.isNotEmpty &&
                    SecondBirthController.text.isNotEmpty &&
                    _selectedValue.isNotEmpty &&
                    PhoneNumberController.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PersonalScreen(NBTN: widget.NBTN)));
                } else {
                  showToast('입력되지 않은 값이 있습니다.');
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30, bottom: 31),
                decoration: const BoxDecoration(
                  color: Color(0xFFD0D0D0),
                ),
                child: const Text(
                  '인증완료',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '인증하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        '휴대폰 인증',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        '이름',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Expanded(
                        flex: 1,
                        child: Container(
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
                          child: DropdownButton(
                            underline: const SizedBox.shrink(),
                            dropdownColor: const Color(0xFFE9F1FF),
                            value: _selectedValue,
                            items: _valueList.map(
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
                                _selectedValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
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
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: userNameController,
                          maxLength: 6,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Color(0xFFE9F1FF),
                            hintText: '본인 실명',
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
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        '주민등록번호 입력',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F1FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: FirstBirthController,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Color(0xFFE9F1FF),
                              hintText: '6자리 입력',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F1FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 35,
                                child: TextFormField(
                                  controller: SecondBirthController,
                                  inputFormatters: [privateFormatter],
                                  maxLength: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: Color(0xFFE9F1FF),
                                    hintText: '주민번호 뒷자리',
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              for (int i = 0; i < 6; i++)
                                Transform.translate(
                                  offset: const Offset(-8, 0),
                                  child: const Icon(
                                    Icons.circle,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        '휴대폰 정보',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 15,
                      //   ),
                      //   child: Container(
                      //     padding: const EdgeInsets.only(
                      //       left: 15,
                      //       right: 15,
                      //       top: 5,
                      //       bottom: 5,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFFE9F1FF),
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: DropdownButton(
                      //       underline: const SizedBox.shrink(),
                      //       dropdownColor: const Color(0xFFE9F1FF),
                      //       value: _selectedValue2,
                      //       items: _valueList2.map(
                      //         (value) {
                      //           return DropdownMenuItem(
                      //             value: value,
                      //             child: Text(
                      //               value,
                      //               style: const TextStyle(
                      //                 fontSize: 20,
                      //               ),
                      //             ),
                      //           );
                      //         },
                      //       ).toList(),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           _selectedValue2 = value!;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9F1FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: TextFormField(
                            controller: PhoneNumberController,
                            inputFormatters: [maskFormatter],
                            textAlign: TextAlign.center,
                            maxLength: 13,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Color(0xFFE9F1FF),
                              hintText: '010-0000-0000',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 21),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              List<String> phoneList =
                                  PhoneNumberController.text.split('-');
                              await auth.verifyPhoneNumber(
                                  phoneNumber:
                                      "+82 10${phoneList[1]}${phoneList[2]}",
                                  verificationCompleted:
                                      (PhoneAuthCredential credential) async {
                                    await auth.signInWithCredential(credential);
                                  },
                                  verificationFailed:
                                      (FirebaseAuthException e) {
                                    if (e.code == 'invalid-phone-number') {
                                      print(
                                          "The provided phone number is not valid.");
                                    }
                                  },
                                  codeSent: (String verificationId,
                                      forceResendingToken) async {
                                    String otpCode = otpController.text;
                                    setState(() {
                                      _codeSent = true;
                                      _verificationId = verificationId;
                                    });
                                  },
                                  codeAutoRetrievalTimeout: (verificationId) {
                                    print(
                                        'handling code auto retrieval timeout');
                                  });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              left: 10,
                              right: 10,
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 142, 183, 255),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              '전송',
                              style: TextStyle(
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE9F1FF),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: Color(0xFFE9F1FF),
                                hintText: '인증번호 입력',
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                verificationId: _verificationId,
                                smsCode: otpController.text,
                              );
                              await auth.signInWithCredential(credential).then(
                                  (_) => Navigator.pushNamed(context, "/"));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 16,
                                bottom: 16,
                              ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 142, 183, 255),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '확인',
                                style: TextStyle(
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
