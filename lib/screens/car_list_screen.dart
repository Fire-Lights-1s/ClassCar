import 'package:flutter/material.dart';
import '../widgets/car_item.dart';
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
        foregroundColor: Colors.black,
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
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //CarListItem() 매개변수 firestore 연결하면 문서 아이디로 바꿀 계획임
            CarListItem(
              carName: "소나타1",
              shareCount: 2,
              park: true,
            ),
            CarListItem(
              carName: "소나타2",
              shareCount: 3,
              park: false,
            ),
            CarListItem(
              carName: "소나타3",
              shareCount: 4,
              park: true,
            ),
            CarListItem(
              carName: "소나타4",
              shareCount: 5,
              park: true,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
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
      ),
    );
  }
}
