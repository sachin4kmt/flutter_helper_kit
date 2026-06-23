import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget formattersDemo(BuildContext context) {
  final controller = TextEditingController();
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          controller: controller,
          inputFormatters: [
            NoLeadingSpaceFormatter(),
            NoSpaceFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'No leading/trailing spaces',
            border: OutlineInputBorder(),
            helperText: 'NoLeadingSpaceFormatter + NoSpaceFormatter',
          ),
        ),
      ],
    ),
  );
}
