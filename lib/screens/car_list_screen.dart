import 'package:flutter/material.dart';

import '../widgets/car_List_item.dart';
import '../widgets/underbar_icon.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          '차량 관리',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    CarListItem(
                      carName: "소나타",
                      shareCount: 2,
                      park: true,
                    ),
                    CarListItem(
                      carName: "소나타",
                      shareCount: 3,
                      park: false,
                    ),
                    CarListItem(
                      carName: "소나타",
                      shareCount: 4,
                      park: true,
                    ),
                    CarListItem(
                      carName: "소나타",
                      shareCount: 5,
                      park: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
            child: Row(
              children: [
                UnderBarIcon(
                  icon: Icons.home_rounded,
                  iconColor: Colors.grey,
                ),
                UnderBarIcon(
                  icon: Icons.directions_car_rounded,
                  iconColor: Colors.black,
                ),
                UnderBarIcon(
                  icon: Icons.description,
                  iconColor: Colors.grey,
                ),
                UnderBarIcon(
                  icon: Icons.person_rounded,
                  iconColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
