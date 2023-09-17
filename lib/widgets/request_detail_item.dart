import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../screens/request_detail_item_screen.dart';
import 'package:flutter/material.dart';

class RequestDetailListItem extends StatelessWidget {
  final Timestamp RentalStartTime;
  final Timestamp RentalEndTime;
  final String Name;
  String Situation;
  final Timestamp RequestDate;
  final int RentalCost;
  final String PhoneNum;
  final String CarName;
  final String CarNum;
  final String SharePlaceName;
  final String ProfileUrl;
  final String OwnerUid;
  final String CarUID;
  final String DriverUID;
  final String documentID;

  RequestDetailListItem({
    super.key,
    required this.RentalStartTime,
    required this.RentalEndTime,
    required this.Name,
    required this.Situation,
    required this.RequestDate,
    required this.RentalCost,
    required this.CarName,
    required this.CarNum,
    required this.PhoneNum,
    required this.SharePlaceName,
    required this.ProfileUrl,
    required this.OwnerUid,
    required this.CarUID,
    required this.DriverUID,
    required this.documentID,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    DateTime rentalEndTime = RentalEndTime.toDate();

    DateTime oneWeekLater = rentalEndTime.add(const Duration(days: 7));

    if (oneWeekLater.isBefore(currentTime)) {
      return const SizedBox.shrink();
    }
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
              RentalStartTime: RentalStartTime,
              RentalEndTime: RentalEndTime,
              Name: Name,
              Situation: Situation,
              RequestDate: RequestDate,
              RentalCost: RentalCost,
              PhoneNum: PhoneNum,
              CarName: CarName,
              CarNum: CarNum,
              SharePlaceName: SharePlaceName,
              documentID: documentID,
              ProfileUrl: ProfileUrl,
              OwnerUid: OwnerUid,
              CarUID: CarUID,
              DriverUID: DriverUID,
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
                                  : Situation == "취소"
                                      ? Colors.red
                                      : Situation == "운행완료"
                                          ? Colors.green
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
                                    : Situation == "취소"
                                        ? Colors.white
                                        : Situation == "운행완료"
                                            ? Colors.white
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
                    child: ClipOval(
                      child: ProfileUrl.isNotEmpty
                          ? Image.network(
                              ProfileUrl,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.white,
                              width: double.infinity,
                              height: double.infinity,
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
                    "${DateFormat('MM/dd(E)HH:mm', 'ko').format(RentalStartTime.toDate())}~${DateFormat('MM/dd(E)HH:mm', 'ko').format(RentalEndTime.toDate())}",
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
                    child: Text(
                        "${DateFormat('yyyy년 MM월 dd일').format(RequestDate.toDate())} 요청함",
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
