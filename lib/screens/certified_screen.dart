import 'package:flutter/material.dart';

class CertifiedScreen extends StatefulWidget {
  const CertifiedScreen({super.key});

  @override
  State<CertifiedScreen> createState() => _CertifiedScreenState();
}

class _CertifiedScreenState extends State<CertifiedScreen> {
  var _selectedValue = '내국인';
  final _valueList = ['내국인', '외국인'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '인증하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    '휴대폰 인증',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    '이름',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F1FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox.shrink(),
                        dropdownColor: const Color(0xFFE9F1FF),
                        value: _selectedValue,
                        items: _valueList.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 15,
                      left: 15,
                    ),
                    child: TextFormField(
                      maxLength: 3,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color(0xFFE9F1FF),
                        hintText: '본인 실명(통신사 가입 이름)',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
