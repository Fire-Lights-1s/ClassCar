import 'package:flutter/material.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool _isSwitched1 = false;
  bool _isSwitched2 = false;

  void _notificationTap() {
    setState(() {
      _isSwitched1 = !_isSwitched1;
    });
  }

  void _notificationTap2() {
    setState(() {
      _isSwitched2 = !_isSwitched2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '알림 설정',
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
      body: Column(
        children: [
          const SizedBox(height: 50),
          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '알림받기',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                Text(
                  '알림 이러쿵저러쿵 안뜸 저러쿵 이러쿵',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Transform.scale(
              scale: 1.7,
              child: Switch(
                value: _isSwitched1,
                onChanged: (value) {
                  setState(() {
                    _notificationTap();
                  });
                },
                activeColor: Colors.blue,
              ),
            ),
          ),
          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '광고성 알림받기',
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                Text(
                  '알림 이러쿵저러쿵 안뜸 저러쿵 이러쿵',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Transform.scale(
              scale: 1.7,
              child: Switch(
                value: _isSwitched2,
                onChanged: (value) {
                  setState(() {
                    _notificationTap2();
                  });
                },
                activeColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
