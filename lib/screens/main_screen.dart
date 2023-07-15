import 'package:classcar/screens/car_list_screen.dart';
import 'package:classcar/screens/home_screen.dart';
import 'package:classcar/screens/mypage_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/underbar_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _myPage = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const Center(
            child: MyPageScreen(),
          )
        ],
      ),
    );
  }
}
