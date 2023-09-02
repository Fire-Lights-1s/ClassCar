import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckBoxDialog extends StatefulWidget {
  final String title;
  late Map<String, dynamic> options;
  Function onChanged;

  CheckBoxDialog({
    super.key,
    required this.title,
    required this.options,
    required this.onChanged(value),
  });

  @override
  State<CheckBoxDialog> createState() => _CheckBoxDialogState();
}

class _CheckBoxDialogState extends State<CheckBoxDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      title: Container(
        decoration: const BoxDecoration(color: Color(0xFF74B2F2)),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      content: SizedBox(
        // Need to use container to add size constraint.
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var option in widget.options.keys.toList()) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(option, style: const TextStyle(fontSize: 20)),
                  Checkbox(
                    value: widget.options[option],
                    onChanged: (value) {
                      setState(() {
                        widget.options[option] = value!;
                      });
                    },
                  ),
                ],
              ),
            ],
            TextButton(
              onPressed: () {
                widget.onChanged(widget.options);
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF74B2F2),
                  ),
                ),
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF74B2F2),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
