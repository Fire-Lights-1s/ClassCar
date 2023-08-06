import 'package:classcar/screens/car_list_screen.dart';
import 'package:classcar/screens/home_screen.dart';
import 'package:classcar/screens/mypage_screen.dart';
import 'package:classcar/screens/request_detail_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _myPage.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          selectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: '홈페이지',
              icon: Icon(Icons.home_rounded, size: 35),
              backgroundColor: Colors.lightBlue,
            ),
            BottomNavigationBarItem(
              label: '차량관리',
              icon: Icon(Icons.directions_car_rounded, size: 35),
              backgroundColor: Colors.lightBlue,
            ),
            BottomNavigationBarItem(
              label: '요청내역',
              icon: Icon(Icons.description, size: 35),
              backgroundColor: Colors.lightBlue,
            ),
            BottomNavigationBarItem(
              label: '마이페이지',
              icon: Icon(Icons.person_rounded, size: 35),
              backgroundColor: Colors.lightBlue,
            ),
          ],
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _myPage,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: [
              Center(
                child: HomeScreen(documentID: widget.documentID),
              ),
              Center(
                child: CarListScreen(documentID: widget.documentID),
              ),
              Center(
                child: RequestDetailListScreen(documentID: widget.documentID),
              ),
              Center(
                child: MyPageScreen(documentID: widget.documentID),
              )
            ],
          ),
        ),
      ),
    );
  }
}
