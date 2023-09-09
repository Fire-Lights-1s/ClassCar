import 'dart:io';

import 'package:classcar/Api/car_DB_connector.dart';
import 'package:classcar/module/car_info_model.dart';
import 'package:classcar/module/user_info_model.dart';
import 'package:classcar/module/user_model.dart';
import 'package:classcar/screens/login_screen.dart';
import 'package:classcar/screens/mywallet_screen.dart';
import 'package:classcar/screens/notice_screen.dart';
import 'package:classcar/screens/notification_setting.dart';
import 'package:classcar/screens/passwordChange_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPageScreen extends StatefulWidget {
  final String documentID;
  const MyPageScreen({super.key, required this.documentID});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late bool carState = false;
  setCarInstances() async {
    List<CarInfoModel> carInstances =
        await CarDataConnector.getUuidCar(widget.documentID);
    if (carInstances.isNotEmpty) {
      carState = carInstances[0].carState;
    }
    setState(() {});
  }

  _launchButton(String url) {
    return InkWell(onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    });
  }

  @override
  initState() {
    setCarInstances();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3A72F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 65,
            ),
            // 프로필부분
            Profile(
              documentID: widget.documentID,
            ),
            const SizedBox(
              height: 20,
            ),

            //회색 배경 컨테이너
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Row(
                        children: [
                          // 내 지갑 버튼
                          Flexible(
                            flex: 1,
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyWalletScreen(
                                                    documentID:
                                                        widget.documentID)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '내 지갑',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                '35,000원',
                                                style: TextStyle(
                                                  color: Color(0xFF74B2F2),
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: Icon(Icons.money_rounded, size: 60),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),

                          //차량 관리 버튼
                          Flexible(
                            flex: 1,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              '차량확인',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            carState
                                                ? const Text(
                                                    '미 운행중',
                                                    style: TextStyle(
                                                      color: Color(0xFF74B2F2),
                                                      fontSize: 20,
                                                    ),
                                                  )
                                                : const Text(
                                                    '운행중',
                                                    style: TextStyle(
                                                      color: Color(0xFF74B2F2),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child:
                                      Icon(Icons.drive_eta_rounded, size: 60),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // 공지사항 버튼
                        Flexible(
                          flex: 1,
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NoticeScreen(
                                              documentID: widget.documentID)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '공지사항',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              '텍스트 없음',
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: 10,
                                bottom: 0,
                                child:
                                    Icon(Icons.announcement_outlined, size: 60),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        //1대1 상담버튼
                        Flexible(
                          flex: 1,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  launch("tel://01012345678");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '1:1 상담',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Text(
                                              '텍스트 없음',
                                              style: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: 10,
                                bottom: 0,
                                child:
                                    Icon(Icons.support_agent_rounded, size: 60),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //설정
                    const Row(
                      children: [
                        Text(
                          '설정',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationSetting(
                                          documentID: widget.documentID,
                                        )));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(
                                      Icons.notifications_active_outlined,
                                      size: 45),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    '알림',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                        Icons.arrow_forward_ios_rounded)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasswordChangeScreen(
                                        documentID: widget.documentID)));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Icon(Icons.lock_open, size: 45),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    '비밀번호 변경',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: const Icon(
                                        Icons.arrow_forward_ios_rounded)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 2,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  final String documentID;

  const Profile({
    super.key,
    required this.documentID,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final picker = ImagePicker();
  String name = '...';
  XFile? image;
  // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = [];
  // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = [];
  // 가져온 사진들을 보여주기 위한 변수

  Future<String> getPhoto() async {
    String result = '';
    UserInfoModel user = await UserInfoUpdate.getUser(widget.documentID);
    if (user.profileUrl != null) {
      result = user.profileUrl!;
    }

    return result;
  }

  //카메라 불러오는 함수
  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref("userProfile/").child('${widget.documentID}.jpg');
    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      await ref.putFile(File(image!.path));
      var downloadUrl = await ref.getDownloadURL();
      UserInfoUpdate.setUserImage(widget.documentID, downloadUrl);
      print("이미지 url = $downloadUrl");
      setState(() {});
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  //갤러리 불러오는 함수
  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref("userProfile/").child('${widget.documentID}.jpg');

    if (pickedFile != null) {
      setState(() {
        image = pickedFile;
      });
      await ref.putFile(File(image!.path));
      var downloadUrl = await ref.getDownloadURL();
      UserInfoUpdate.setUserImage(widget.documentID, downloadUrl);
      print("이미지 url = $downloadUrl");
      setState(() {});
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getUserName() async {
    name = await UserInfoUpdate.getName(widget.documentID);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 150,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          )),
                          title: const Text('사진을 업로드하세요'),
                          actions: <Widget>[
                            IconButton(
                              onPressed: () => _getCameraImage(),
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _getPhotoLibraryImage(),
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: FutureBuilder(
                      future: getPhoto(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData == false) {
                          return const Icon(
                            Icons.account_circle,
                            size: 100,
                          );
                        } else {
                          if (snapshot.data == '') {
                            return Transform.translate(
                              offset: const Offset(-26, -25),
                              child: const Icon(
                                Icons.account_circle,
                                size: 200,
                              ),
                            );
                          }
                          return Transform.scale(
                              scale: 2.0,
                              child: Image.network(snapshot.data.toString()));
                        }
                      }),
                ),
              )
            ],
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'abcdefg@gmail.com',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB3B3B3),
            ),
          ),
        ],
      ),
    );
  }
}
