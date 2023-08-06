import '../screens/car_item_screen.dart';
import 'package:flutter/material.dart';

class CarListItem extends StatelessWidget {
  final String carName;
  final int shareCount;
  final bool park;
  final String documentID;

  const CarListItem({
    super.key,
    required this.carName,
    required this.shareCount,
    required this.park,
    required this.documentID,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                CarDetailScreen(
              carName: carName,
              documentID: documentID,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "대여 횟수",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "$shareCount 회",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            park ? "주차 중" : "주행 중",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.directions_car_rounded,
                            size: 50,
                            color: park ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
