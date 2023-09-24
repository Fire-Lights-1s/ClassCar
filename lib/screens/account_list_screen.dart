import 'package:classcar/module/user_info_model.dart';
import 'package:classcar/module/user_model.dart';
import 'package:flutter/material.dart';

class AccountListScreen extends StatefulWidget {
  final documentID;
  const AccountListScreen({
    super.key,
    this.documentID,
  });

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  var _text = '은행선택';
  Color _color = Colors.grey;
  bool make = true;
  int counter = 0;
  String inputText = '';

  List<dynamic> account = [];

  final _accountNumberEditController = TextEditingController();

  Future<UserInfoModel> getUser() async {
    final UserInfoModel userData =
        await UserInfoUpdate.getUser(widget.documentID);
    if (userData.bankList != null) {
      account = userData.bankList!;
    }

    return userData;
  }

  @override
  void dispose() {
    _accountNumberEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '계좌 관리',
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
              const SizedBox(height: 80),

              //은행선택, 계좌입력 컨테이너
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: const Offset(2, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      //은행 선택버튼
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 10,
                                          bottom: 30,
                                        ),
                                        height: 300,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Text(
                                                '은행선택',
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 20),

                                              //국민은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '국민은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/국민은행_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              //UnderLine 아래 위젯분리
                                              const UnderLine(),
                                              const SizedBox(height: 15),

                                              //농협은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '농협은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/농협_로고.png"),
                                                    width: 120,
                                                    height: 25,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //부산은행
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _text = '부산은행';
                                                      _color = Colors.black;
                                                    });
                                                  },
                                                  child: const BankContainer(
                                                    bankImage: Image(
                                                      image: AssetImage(
                                                          "assets/images/부산은행_로고.png"),
                                                      width: 120,
                                                      height: 40,
                                                    ),
                                                  )),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //신한은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '신한은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/신한뱅크_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //우리은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '우리은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/우리은행_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //카카오뱅크
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '카카오뱅크';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/카카오뱅크_로고.png"),
                                                    width: 300,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //토스뱅크
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '토스뱅크';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/토스뱅크_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //하나은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '하나은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/하나은행_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //IBK기업은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = 'IBK기업은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankImage: Image(
                                                    image: AssetImage(
                                                        "assets/images/기업은행_로고.png"),
                                                    width: 120,
                                                    height: 40,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //SC제일은행
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _text = 'SC제일은행';
                                                      _color = Colors.black;
                                                    });
                                                  },
                                                  child: const BankContainer(
                                                    bankImage: Image(
                                                      image: AssetImage(
                                                          "assets/images/SC제일은행_로고.png"),
                                                      width: 120,
                                                      height: 40,
                                                    ),
                                                  )),
                                              const SizedBox(height: 10),
                                              const UnderLine(),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9F1FF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  _text,
                                  style: TextStyle(
                                    color: _color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      //계좌 입력부분
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 8,
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE9F1FF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _accountNumberEditController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: '계좌번호를 입력하세요',
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  counterText: '',
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              //계좌추가 버튼부분
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            for (int i = 0; i < account.length; i++) {
                              if (_accountNumberEditController.text ==
                                      account[i]['bankNum'].toString() &&
                                  _text == account[i]['bank'].toString()) {
                                make = false;

                                break;
                              } else {
                                make = true;
                              }
                            }
                            if (make) {
                              account.add({
                                "bank": _text,
                                "bankNum": _accountNumberEditController.text
                              });
                              UserInfoUpdate.updataData(
                                  "bankList", account, widget.documentID);
                              print('업데이트');
                            }
                          });
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
                            '계좌 추가',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.hasError);
                      return const Text("정보가져오기 실패");
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          for (var bank in account) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFE9F1FF),
                                      ),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(Icons.money),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                bank['bank'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Text(
                                              bank['bankNum'].toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  left: 2,
                                                  right: 2,
                                                  top: 2,
                                                  bottom: 2,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFBA45),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: const Text('주계좌'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class UnderLine extends StatelessWidget {
  const UnderLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class BankContainer extends StatefulWidget {
  final String? bankNames;
  final Image bankImage;

  const BankContainer({
    super.key,
    this.bankNames,
    required this.bankImage,
  });

  @override
  State<BankContainer> createState() => _BankContainerState();
}

class _BankContainerState extends State<BankContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.bankImage,
          Text(
            widget.bankNames == null ? "" : widget.bankNames!,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
