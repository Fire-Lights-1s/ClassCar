import 'package:flutter/material.dart';
import '../widgets/request_detail_item.dart';

class RequestDetailListScreen extends StatefulWidget {
  final String documentID;
  const RequestDetailListScreen({super.key, required this.documentID});

  @override
  State<RequestDetailListScreen> createState() =>
      _RequestDetailListScreenState();
}

class _RequestDetailListScreenState extends State<RequestDetailListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '요청 내역',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RequestDetailListItem(
              Name: "홍길동",
              Situation: "수락대기",
              RentalDate: "05/19(금)13:00~05/19(금)22:00",
              RequestDate: "2023년 05월 05일",
              RentalCost: 50000,
              DuringTime: "10시간",
              PhoneNum: "010-4417-8841",
              UserAddress: "부산광역시 해운대구----",
              CarName: "쏘나타 8세대",
              CarNum: "부산98배1234",
              ShareDetailPlace: "e편한세상 금정산 아파트",
              SharePlaceName: "부산광역시 북구 상학로 36",
            ),
            RequestDetailListItem(
              Name: "김심청",
              Situation: "수락",
              RentalDate: "05/11(목)13:00~05/11(목)22:00",
              RequestDate: "2023년 05월 03일",
              RentalCost: 50000,
              DuringTime: "10시간",
              PhoneNum: "010-1234-8841",
              UserAddress: "부산광역시 해운대구----",
              CarName: "쏘나타 8세대",
              CarNum: "부산98배1234",
              ShareDetailPlace: "e편한세상 금정산 아파트",
              SharePlaceName: "부산광역시 북구 상학로 36",
            ),
            RequestDetailListItem(
              Name: "김심청",
              Situation: "운행중",
              RentalDate: "05/05(금)13:00~05/05(금)23:00",
              RequestDate: "2023년 05월 03일",
              RentalCost: 55000,
              DuringTime: "11시간",
              PhoneNum: "010-1234-8841",
              UserAddress: "부산광역시 해운대구----",
              CarName: "쏘나타 8세대",
              CarNum: "부산98배1234",
              ShareDetailPlace: "e편한세상 금정산 아파트",
              SharePlaceName: "부산광역시 북구 상학로 36",
            ),
            RequestDetailListItem(
              Name: "김이박",
              Situation: "취소",
              RentalDate: "05/02(화)13:00~05/02(화)23:00",
              RequestDate: "2023년 05월 01일",
              RentalCost: 55000,
              DuringTime: "11시간",
              PhoneNum: "010-1234-5678",
              UserAddress: "부산광역시 북구----",
              CarName: "쏘나타 8세대",
              CarNum: "부산98배1234",
              ShareDetailPlace: "e편한세상 금정산 아파트",
              SharePlaceName: "부산광역시 북구 상학로 36",
            ),
          ],
        ),
      ),
    );
  }
}
