import 'package:classcar/Api/car_DB_connector.dart';
import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/screens/car_info_upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  // late Future<List<CarInfoModel>> carModels =
  //     CarDataConnector.getUuidCar(widget.documentID);
  Future<List<CarInfoModel>> getCarList() async {
    Future<List<CarInfoModel>> carModels =
        CarDataConnector.getUuidCar(widget.documentID);
    return carModels;
  }

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
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Car')
              .where("uuid", isEqualTo: widget.documentID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final docs = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = docs[index].data();
                CarInfoModel carData =
                    CarInfoModel.fromJson(docs[index].id, data);
                return CarListItem(
                  carModel: carData,
                  documentID: widget.documentID,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CarDataUpload(
                documentID: widget.documentID,
              ),
            ),
          );
        },
      ),
    );
  }
}
