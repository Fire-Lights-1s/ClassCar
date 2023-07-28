import 'package:classcar/screens/car_list_screen.dart';
import 'package:classcar/screens/home_screen.dart';
import 'package:classcar/screens/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/underbar_icon.dart';

class MainScreen extends StatefulWidget {
  final String documentID;
  const MainScreen({super.key, required this.documentID});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _myPage = PageController(initialPage: 0);

  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              '종료 하시겠습니까?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  //앱 자체 종료
                  SystemNavigator.pop();
                },
                child: const Text('종료'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('취소'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackKey();
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _myPage.jumpToPage(0);
                      });
                    },
                    child: const UnderBarIcon(
                      icon: Icons.home_rounded,
                      iconColor: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _myPage.jumpToPage(1);
                      });
                    },
                    child: const UnderBarIcon(
                      icon: Icons.directions_car_rounded,
                      iconColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _myPage.jumpToPage(2);
                      });
                    },
                    child: const UnderBarIcon(
                      icon: Icons.description,
                      iconColor: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _myPage.jumpToPage(3);
                      });
                    },
                    child: const UnderBarIcon(
                      icon: Icons.person_rounded,
                      iconColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _myPage,
          children: [
            const Center(
              child: HomeScreen(),
            ),
            const Center(
              child: CarListScreen(),
            ),
            Center(
              child: Container(
                child: const Text('Empty Body 2'),
              ),
            ),
            Center(
              child: MyPageScreen(documentID: widget.documentID),
            )
          ],
        ),
      ),
    );
  }
}
