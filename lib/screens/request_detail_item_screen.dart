import 'package:classcar/Api/car_DB_connector.dart';
import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/screens/car_item_screen.dart';
import 'package:classcar/screens/car_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../module/request_info_model.dart';
import '../module/request_model.dart';

class RequestDetailItemScreen extends StatefulWidget {
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

  final firestore = FirebaseFirestore.instance;

  //fianl 추가해야함
  RequestDetailItemScreen({
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
  State<RequestDetailItemScreen> createState() =>
      _RequestDetailItemScreenState();
}

class _RequestDetailItemScreenState extends State<RequestDetailItemScreen> {
  late Future<List<RequestInfoModel>> requestInfoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            const Text(
              '요청 상세',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 60,
            ),
            Container(
              width: 80,
              height: 23,
              decoration: BoxDecoration(
                color: widget.Situation == "수락대기"
                    ? Colors.black
                    : widget.Situation == "운행중"
                        ? Colors.yellow
                        : widget.Situation == "수락"
                            ? Colors.grey
                            : widget.Situation == "취소"
                                ? Colors.red
                                : widget.Situation == "운행완료"
                                    ? Colors.green
                                    : null,
              ),
              child: Text(
                widget.Situation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.Situation == "수락대기"
                      ? Colors.white
                      : widget.Situation == "운행중"
                          ? Colors.black
                          : widget.Situation == "수락"
                              ? Colors.black
                              : widget.Situation == "취소"
                                  ? Colors.white
                                  : widget.Situation == "운행완료"
                                      ? Colors.white
                                      : null,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<RequestInfoModel>>(
          stream: RequestInfoUpdate.getStreamDataUid(widget.documentID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<RequestInfoModel> requestInstances = snapshot.data ?? [];

              Duration duration = widget.RentalEndTime.toDate()
                  .difference(widget.RentalStartTime.toDate());

              int totalMinutes = duration.inMinutes;

              int DuringHours = totalMinutes ~/ 60;
              int DuringMinutes = totalMinutes % 60;

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: const Color(0xFFE9F1FF),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "이용 기간",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${DateFormat('MM/dd(E)HH:mm', 'ko').format(widget.RentalStartTime.toDate())}~${DateFormat('MM/dd(E)HH:mm', 'ko').format(widget.RentalEndTime.toDate())}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "  총 $DuringHours시간 $DuringMinutes분 이용",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "이용자 정보",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                width: 103,
                                height: 99,
                                child: ClipOval(
                                  child: widget.ProfileUrl.isNotEmpty
                                      ? Image.network(
                                          widget.ProfileUrl,
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
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.Name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.PhoneNum,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${DateFormat('yyyy년 MM월 dd일').format(widget.RequestDate.toDate())} 요청함",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "내차량 정보",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () async {
                                  List<CarInfoModel> carlist =
                                      await CarDataConnector.getCarDocId(
                                          widget.CarUID);
                                  if (carlist.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CarDetailScreen(
                                                  documentID: widget.OwnerUid,
                                                  carModel: carlist[0],
                                                )));
                                  }
                                },
                                child: Container(
                                    width: 390,
                                    height: 80,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          widget.CarName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          widget.CarNum,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text(
                              "공유 장소",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${widget.SharePlaceName.split('/')[1]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${widget.SharePlaceName.split('/')[0]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "최종 수익",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${widget.RentalCost}원",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                width: 171,
                                height: 38,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text("상세내역 보기",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Row(
                          children: [
                            Text(
                              "수락 상태",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.Situation == "수락대기")
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 10, 20),
                                  width: 375,
                                  height: 160,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Column(children: [
                                    Column(
                                      children: [
                                        const Text(
                                          "수락대기 상태입니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: const Row(
                                                            children: [
                                                              Text(
                                                                "수락하시겠습니까?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          insetPadding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 80, 0, 80),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  "확인"),
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    newStatus =
                                                                    "수락";

                                                                await RequestInfoUpdate
                                                                    .updateRequestSituation(
                                                                        widget
                                                                            .documentID,
                                                                        newStatus);

                                                                setState(() {
                                                                  widget.Situation =
                                                                      "수락";
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  "닫기"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ]);
                                                    });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(14),
                                                width: 130,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFD9D9D9)),
                                                child: const Text(
                                                  "수락하기",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: const Row(
                                                            children: [
                                                              Text(
                                                                "요청을 거절 하시겠습니까?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          insetPadding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 80, 0, 80),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  "확인"),
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    newStatus =
                                                                    "취소";

                                                                await RequestInfoUpdate
                                                                    .updateRequestSituation(
                                                                        widget
                                                                            .documentID,
                                                                        newStatus);

                                                                setState(() {
                                                                  widget.Situation =
                                                                      "취소";
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  "닫기"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ]);
                                                    });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(14),
                                                width: 130,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFD9D9D9)),
                                                child: const Text(
                                                  "거절하기",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          )
                        else if (widget.Situation == "수락")
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 10, 20),
                                  width: 375,
                                  height: 160,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Column(children: [
                                    Column(
                                      children: [
                                        const Text(
                                          "수락완료 상태입니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: const Row(
                                                            children: [
                                                              Text(
                                                                "요청을 거절 하시겠습니까?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          insetPadding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  0, 80, 0, 80),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  "확인"),
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    newStatus =
                                                                    "취소";

                                                                await RequestInfoUpdate
                                                                    .updateRequestSituation(
                                                                        widget
                                                                            .documentID,
                                                                        newStatus);

                                                                setState(() {
                                                                  widget.Situation =
                                                                      "취소";
                                                                });

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  "닫기"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ]);
                                                    });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(14),
                                                width: 275,
                                                height: 50,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFD9D9D9)),
                                                child: const Text(
                                                  "거절하기",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          )
                        else if (widget.Situation == "운행중")
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 10, 20),
                                  width: 375,
                                  height: 80,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Column(children: [
                                    Column(
                                      children: [
                                        Text(
                                          "운행중 입니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          )
                        else if (widget.Situation == "취소")
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 10, 20),
                                  width: 375,
                                  height: 80,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Column(children: [
                                    Column(
                                      children: [
                                        Text(
                                          "취소 되었습니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          )
                        else if (widget.Situation == "운행완료")
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 10, 20),
                                  width: 375,
                                  height: 80,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: const Column(children: [
                                    Column(
                                      children: [
                                        Text(
                                          "운행완료 되었습니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
