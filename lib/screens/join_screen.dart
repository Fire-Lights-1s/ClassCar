import 'package:classcar/screens/certified_screen.dart';
import 'package:flutter/material.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final String _agreement = 'Yes';
  final String _adagreement = 'AgreeYes';

  final ScrollController controllerOne = ScrollController();

  final ScrollController controllerTwo = ScrollController();

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
      body: SingleChildScrollView(
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
                    '회원가입',
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
              height: 170,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '약관동의',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: RawScrollbar(
                      thumbVisibility: true,
                      minThumbLength: 100,
                      controller: controllerOne,
                      thumbColor: const Color(0xFFD1E4FF),
                      child: Container(
                        width: 1000,
                        height: 110,
                        color: const Color.fromARGB(255, 243, 247, 255),
                        child: ListView(
                          controller: controllerOne,
                          children: const [
                            Text(
                              '약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: -4),
                    contentPadding: const EdgeInsets.only(left: 190),
                    title: const Text('약관에 동의합니다'),
                    leading: Radio(
                      value: 'Yes',
                      groupValue: _agreement,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '약관동의',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: RawScrollbar(
                      thumbVisibility: true,
                      minThumbLength: 100,
                      controller: controllerTwo,
                      thumbColor: const Color(0xFFD1E4FF),
                      child: Container(
                        width: 1000,
                        height: 110,
                        color: const Color.fromARGB(255, 243, 247, 255),
                        child: ListView(
                          controller: controllerTwo,
                          children: const [
                            Text(
                              '약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기 약관 어쩌구저쩌구 솰라솰라 약관머시기저시기',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: -4),
                    contentPadding: const EdgeInsets.only(left: 190),
                    title: const Text('약관에 동의합니다'),
                    leading: Radio(
                      value: 'Yes',
                      groupValue: _agreement,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 1000,
                    height: 30,
                    color: const Color.fromARGB(255, 243, 247, 255),
                    child: const Text(
                      '(선택)업데이트, 이벤트 등 광고성 메일 수신 동의',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListTile(
                    visualDensity: const VisualDensity(horizontal: -4),
                    contentPadding: const EdgeInsets.only(left: 190),
                    title: const Text('약관에 동의합니다'),
                    leading: Radio(
                      value: 'AgreeYes',
                      groupValue: _adagreement,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF74B2F2),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
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
                          builder: (context) => const CertifiedScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 31,
                  ),
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
          ],
        ),
      ),
    );
  }
}
