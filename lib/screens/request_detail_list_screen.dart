import 'package:classcar/module/appNotification.dart';
import 'package:classcar/module/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../module/request_info_model.dart';
import '../widgets/request_detail_item.dart';

class RequestDetailListScreen extends StatefulWidget {
  final firestore = FirebaseFirestore.instance;
  final String documentID;

  RequestDetailListScreen({super.key, required this.documentID});

  @override
  State<RequestDetailListScreen> createState() =>
      _RequestDetailListScreenState();
}

class _RequestDetailListScreenState extends State<RequestDetailListScreen> {
  late Future<List<RequestInfoModel>> requestInfoList;

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
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<RequestInfoModel>>(
          stream: RequestInfoUpdate.getStreamDataUid5(widget.documentID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              RequestInfoUpdate.updateRequestSituationCancel();
              RequestInfoUpdate.updateRequestSituationDriving();
              RequestInfoUpdate.updateRequestSituationDrivingComplete();

              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<RequestInfoModel> requestInstances = snapshot.data ?? [];

              return Column(
                children: requestInstances.map((requestInfo) {
                  return RequestDetailListItem(
                    Name: requestInfo.Name,
                    Situation: requestInfo.Situation,
                    CarName: requestInfo.CarName,
                    CarNum: requestInfo.CarNum,
                    PhoneNum: requestInfo.PhoneNum,
                    RentalCost: requestInfo.RentalCost,
                    RentalStartTime: requestInfo.RentalStartTime,
                    RentalEndTime: requestInfo.RentalEndTime,
                    RequestDate: requestInfo.RequestDate,
                    SharePlaceName: requestInfo.SharePlaceName,
                    ProfileUrl: requestInfo.ProfileUrl,
                    OwnerUid: requestInfo.OwnerUid,
                    documentID: requestInfo.documentID,
                    CarUID: requestInfo.CarUID,
                    DriverUID: requestInfo.DriverUID,
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
