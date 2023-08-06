import 'package:flutter/material.dart';

class NoticeScreen extends StatefulWidget {
  final String documentID;
  const NoticeScreen({
    super.key,
    required this.documentID,
  });

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  bool _buttonactive = false;
  bool _buttonactive2 = false;
  bool _buttonactive3 = false;

  void _handleTap() {
    setState(() {
      _buttonactive = !_buttonactive;
    });
  }

  void _handleTap2() {
    setState(() {
      _buttonactive2 = !_buttonactive2;
    });
  }

  void _handleTap3() {
    setState(() {
      _buttonactive3 = !_buttonactive3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '공지사항',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: InkWell(
                onTap: () {
                  _handleTap();
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '공지사항 1 제목',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '2023. 07. 01',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: AnimatedContainer(
                width: double.infinity,
                height: _buttonactive ? 300 : 0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                duration: const Duration(
                  seconds: 1,
                ),
                curve: Curves.fastOutSlowIn,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: const Text('새로운 기능을 소개해 드립니다!'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD0D0D0),
                              ),
                              alignment: Alignment.center,
                              child: const Text('사진 넣는 공간'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: InkWell(
                onTap: () {
                  _handleTap2();
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '공지사항 2 제목',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '2023. 07. 01',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: AnimatedContainer(
                width: double.infinity,
                height: _buttonactive2 ? 300 : 0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                duration: const Duration(
                  seconds: 1,
                ),
                curve: Curves.fastOutSlowIn,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: const Text('새로운 기능을 소개해 드립니다!'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD0D0D0),
                              ),
                              alignment: Alignment.center,
                              child: const Text('사진 넣는 공간'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: InkWell(
                onTap: () {
                  _handleTap3();
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '공지사항 3 제목',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '2023. 06. 28',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: AnimatedContainer(
                width: double.infinity,
                height: _buttonactive3 ? 300 : 0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                duration: const Duration(
                  seconds: 1,
                ),
                curve: Curves.fastOutSlowIn,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                                left: 5,
                                right: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              ),
                              child: const Text('새로운 기능을 소개해 드립니다!'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD0D0D0),
                              ),
                              alignment: Alignment.center,
                              child: const Text('사진 넣는 공간'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 10),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라'),
                      const Text('새로운 기능 뭐시기저시기 솰라솰라 어쩌구저쩌구'),
                      const SizedBox(height: 20),
                    ],
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
