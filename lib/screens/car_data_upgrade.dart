import 'package:flutter/material.dart';

import '../widgets/underbar_icon.dart';

class CarDataUpgrade extends StatefulWidget {
  final String carName;

  const CarDataUpgrade({
    super.key,
    required this.carName,
  });

  @override
  State<CarDataUpgrade> createState() => _CarDataUpgradeState();
}

class _CarDataUpgradeState extends State<CarDataUpgrade> {
  late TextEditingController carNameTextfiled, carNumTextfiled;
  late TextEditingController carLocTextfiled;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carNameTextfiled = TextEditingController(text: "${widget.carName} 기종 초기값");
    carNumTextfiled = TextEditingController(text: "번호 초기값");
    carLocTextfiled = TextEditingController(text: "차량 위치 초기값");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '차량정보 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              CarInfoInput(
                fractionationInfo: '차량기종',
                hintText: '차량 기종(모델명)',
                textControll: carNameTextfiled,
              ),
              CarInfoInput(
                fractionationInfo: '차량 번호',
                hintText: '차량 번호',
                textControll: carNumTextfiled,
              ),
              CarLocationInput(
                fractionationInfo: '차량 위치',
                hintText: '차량 상세 위치를 입력해주세요',
                textControll: carLocTextfiled,
              ),
              TextButton(
                onPressed: () {
                  print(carNameTextfiled.text);
                },
                child: const Text('test'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.amber,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              UnderBarIcon(
                icon: Icons.home_rounded,
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.directions_car_rounded,
                iconColor: Colors.black,
              ),
              UnderBarIcon(
                icon: Icons.description,
                iconColor: Colors.grey,
              ),
              UnderBarIcon(
                icon: Icons.person_rounded,
                iconColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarInfoInput extends StatelessWidget {
  final String fractionationInfo, hintText;
  final TextEditingController textControll;

  const CarInfoInput({
    super.key,
    required this.fractionationInfo,
    required this.hintText,
    required this.textControll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fractionationInfo,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textControll,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFE9F1FF),
              hintText: hintText,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarLocationInput extends StatelessWidget {
  final String fractionationInfo, hintText;
  final TextEditingController textControll;

  const CarLocationInput({
    super.key,
    required this.fractionationInfo,
    required this.hintText,
    required this.textControll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fractionationInfo,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE9F1FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Text("주소 api 이용해서 수정하도록 해야함"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: textControll,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFE9F1FF),
              hintText: hintText,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
