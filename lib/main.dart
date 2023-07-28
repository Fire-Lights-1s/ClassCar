<<<<<<< HEAD
=======
import 'package:classcar/screens/passwordChange_screen.dart';
>>>>>>> 8e4df4723c4a68f85e03690fe639f761eeca8d44
import 'package:classcar/screens/start_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const MainApp());
  firebase();
}

void firebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;
  print('firebase 가져오기 시작');
  await firestore.collection('userINFO').get().then((event) {
    for (var doc in event.docs) {
      print("결과확인 = ${doc.data()['userId']};");
    }
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(),
    );
  }
}
