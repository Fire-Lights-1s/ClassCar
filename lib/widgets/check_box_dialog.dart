import 'package:flutter/material.dart';

class CheckBoxDialog extends StatelessWidget {
  final String title;
  const CheckBoxDialog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: const SizedBox(
        // Need to use container to add size constraint.
        width: 300,
        height: 300,
      ),
    );
  }
}
