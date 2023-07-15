import 'package:flutter/material.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({
    super.key,
  });

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  var _text = '은행선택';
  Color _color = Colors.grey;
  bool make = false;
  int counter = 0;
  String inputText = '';

  List<Map<String, dynamic>> account = [
    {"bank": "국민은행", "bankNum": 1234567890112},
    {"bank": "신한은행", "bankNum": 1231231231231},
    {"bank": "농협은행", "bankNum": 1234512345123},
  ];

  final _accountNumberEditController = TextEditingController();

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
                                                    bankNames: '국민은행',
                                                    bankColor: Colors.yellow),
                                              ),
                                              const SizedBox(height: 10),
                                              //UnderLine 아래 위젯분리
                                              const UnderLine(),
                                              const SizedBox(height: 10),

                                              //농협은행
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _text = '농협은행';
                                                    _color = Colors.black;
                                                  });
                                                },
                                                child: const BankContainer(
                                                  bankNames: '농협은행',
                                                  bankColor: Colors.green,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
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
                                                  child: BankContainer(
                                                    bankNames: '부산은행',
                                                    bankColor:
                                                        Colors.red.shade300,
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
                                                  bankNames: '신한은행',
                                                  bankColor: Colors.blue,
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
                                                child: BankContainer(
                                                  bankNames: '우리은행',
                                                  bankColor:
                                                      Colors.blue.shade300,
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
                                                child: BankContainer(
                                                  bankNames: '카카오뱅크',
                                                  bankColor:
                                                      Colors.yellow.shade500,
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
                                                  bankNames: '토스뱅크',
                                                  bankColor: Colors.lightBlue,
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
                                                  bankNames: '하나은행',
                                                  bankColor: Colors.blue,
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
                                                  bankNames: 'IBK 기업은행',
                                                  bankColor: Colors.lightBlue,
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
                                                  child: BankContainer(
                                                      bankNames: 'SC제일은행',
                                                      bankColor: Colors
                                                          .blue.shade100)),
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
                        onTap: () {
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
              Column(
                children: [
                  const SizedBox(height: 20),
                  for (int i = 0; i < account.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
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
                                        account[i]['bank'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      account[i]['bankNum'].toString(),
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
                                          color: const Color(0xFFFFBA45),
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
                ],
              ),
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
  final String bankNames;
  final Color bankColor;

  const BankContainer({
    super.key,
    required this.bankNames,
    required this.bankColor,
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
          Icon(
            Icons.house_rounded,
            size: 26,
            color: widget.bankColor,
          ),
          Text(
            widget.bankNames,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
