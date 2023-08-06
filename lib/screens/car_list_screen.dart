import 'package:flutter/material.dart';
import '../widgets/car_item.dart';

class CarListScreen extends StatefulWidget {
  final String documentID;
  const CarListScreen({
    super.key,
    required this.documentID,
  });

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            //CarListItem() 매개변수 firestore 연결하면 문서 아이디로 바꿀 계획임
            CarListItem(
              carName: "소나타1",
              shareCount: 2,
              park: true,
              documentID: widget.documentID,
            ),
            CarListItem(
              carName: "소나타2",
              shareCount: 3,
              park: false,
              documentID: widget.documentID,
            ),
            CarListItem(
              carName: "소나타3",
              shareCount: 4,
              park: true,
              documentID: widget.documentID,
            ),
            CarListItem(
              carName: "소나타4",
              shareCount: 5,
              park: true,
              documentID: widget.documentID,
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
    );
  }
}
