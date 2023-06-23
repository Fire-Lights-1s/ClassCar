import 'package:classcar/screens/personal_screen.dart';
import 'package:flutter/material.dart';
import 'package:classcar/Api/data_model.dart';

class DaumPostcodeSearchExample extends StatefulWidget {
  const DaumPostcodeSearchExample({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _DaumPostcodeSearchExampleState createState() =>
      _DaumPostcodeSearchExampleState();
}

class _DaumPostcodeSearchExampleState extends State<DaumPostcodeSearchExample> {
  DataModel? _daumPostcodeSearchDataModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TableRow _buildTableRow(String label, String value) {
      return TableRow(
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(label, textAlign: TextAlign.center),
          ),
          TableCell(
            child: Text(value, textAlign: TextAlign.center),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      DataModel model = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PersonalScreen(),
                        ),
                      );

                      setState(
                        () {
                          _daumPostcodeSearchDataModel = model;
                        },
                      );
                    } catch (error) {
                      print(error);
                    }
                  },
                  icon: const Icon(Icons.search),
                  label: const Text("주소 검색"),
                ),
                Visibility(
                  visible: _daumPostcodeSearchDataModel != null,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  const TextSpan(text: "주소 검색 결과"),
                                ],
                              ),
                            ),
                          ),
                          Table(
                            border: TableBorder.symmetric(
                                inside: const BorderSide(color: Colors.grey)),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(2),
                            },
                            children: [
                              _buildTableRow(
                                "한글주소",
                                _daumPostcodeSearchDataModel?.address ?? "",
                              ),
                              _buildTableRow(
                                "영문주소",
                                _daumPostcodeSearchDataModel?.addressEnglish ??
                                    "",
                              ),
                              _buildTableRow(
                                "우편번호",
                                _daumPostcodeSearchDataModel?.zonecode ?? "",
                              ),
                              _buildTableRow(
                                "지번주소",
                                _daumPostcodeSearchDataModel
                                        ?.autoJibunAddress ??
                                    "",
                              ),
                              _buildTableRow(
                                "지번주소(영문)",
                                _daumPostcodeSearchDataModel
                                        ?.autoJibunAddressEnglish ??
                                    "",
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
