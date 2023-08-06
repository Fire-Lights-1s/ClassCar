import 'package:flutter/material.dart';

// ignore: must_be_immutable
class YearPickerDialog extends StatelessWidget {
  DateTime selectedDate;
  Function selectYear;

  YearPickerDialog({
    super.key,
    required this.selectedDate,
    required this.selectYear(value),
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Year"),
      content: SizedBox(
        // Need to use container to add size constraint.
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 100, 1),
          lastDate: DateTime(DateTime.now().year, 1),
          initialDate: selectedDate,
          selectedDate: selectedDate,
          onChanged: (DateTime dateTime) {
            selectYear(dateTime);

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
