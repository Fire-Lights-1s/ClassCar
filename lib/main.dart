import 'package:classcar/screens/main_screen.dart';
import 'package:classcar/screens/start_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  var authUser = FirebaseAuth.instance.currentUser;

  if (authUser != null) {
    FirebaseFirestore.instance
        .collection('Rent')
        .where('OwnerUID', isEqualTo: authUser.uid)
        .snapshots()
        .listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            print('대여요청 추가');
            break;
          case DocumentChangeType.modified:
            break;
        }
      }
    });
  }
  print("백그라운드 메세지처리.. ${message.notification!.body!}");
}

// void initializeNotification() async {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(const AndroidNotificationChannel(
//           'high_importance_channel', 'high_importance_notification',
//           importance: Importance.max));

//   await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
//     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   ));

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
// }

void main() async {
  runApp(const MainApp());
  firebase();
}

void firebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "classcar_provider",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initializeNotification();
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? userInfo; //
  static const storage = FlutterSecureStorage();

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      print('유저정보 있음');
      final fireauth = FirebaseAuth.instance;
      await fireauth.signInWithEmailAndPassword(
          email: userInfo!.split(' ')[1], password: userInfo!.split(' ')[3]);
      fireauth.currentUser;
      if (fireauth.currentUser != null) {
      } else {
        print('로그인 실패');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko', 'KR'),
      ],
      home: StartScreen(),
    );
  }
}
