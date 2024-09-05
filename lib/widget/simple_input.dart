import 'package:d_input/d_input.dart';
import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput(
      {super.key,
      required this.edtTitle,
      required this.edtDescription,
      required this.ontap,
      required this.actionTitle});
  final TextEditingController edtTitle;
  final TextEditingController edtDescription;
  final VoidCallback ontap;
  final String actionTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DInput(
          controller: edtTitle,
          title: "Title",
        ),
        const SizedBox(height: 16),
        DInput(
          controller: edtDescription,
          title: "Description",
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: ontap, child: Text(actionTitle))
      ],
    );
  }
}
