import '../screens/request_detail_item_screen.dart';
import 'package:flutter/material.dart';

class RequestDetailListItem extends StatelessWidget {
  final String Situation;
  final String Name;
  final String RentalDate;
  final String RequestDate;
  final int RentalCost;

  const RequestDetailListItem({
    super.key,
    required this.Situation,
    required this.Name,
    required this.RentalDate,
    required this.RequestDate,
    required this.RentalCost,
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
                RequestDetailItemScreen(
              RentalDate: RentalDate,
              Name: Name,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFE9F1FF)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 80,
                    height: 23,
                    decoration: BoxDecoration(
                      color: Situation == "수락대기"
                          ? Colors.black
                          : Situation == "운행중"
                              ? Colors.yellow
                              : Situation == "수락"
                                  ? Colors.grey
                                  : null,
                    ),
                    child: Text(
                      Situation,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Situation == "수락대기"
                            ? Colors.white
                            : Situation == "운행중"
                                ? Colors.black
                                : Situation == "수락"
                                    ? Colors.black
                                    : null,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 87,
                    height: 90,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: 75,
                    height: 23,
                    child: Text(
                      Name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: SizedBox(
                  width: 250,
                  height: 25,
                  child: Text(
                    RentalDate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                    child: Text("$RequestDate 요청함",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                    child: Text("$RentalCost원",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
