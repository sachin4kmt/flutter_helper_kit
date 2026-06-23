import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget rxDatetimeDemo(BuildContext context) {
  final rx = RxDateTime.now();
  return ValueListenableBuilder<DateTime>(
    valueListenable: rx,
    builder: (_, value, __) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('RxDateTime.value: ${rx.format()}'),
          Text('timeAgo(): ${rx.timeAgo()}'),
          Text('isToday: ${rx.isToday}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => rx.addDuration(const Duration(hours: 1)),
            child: const Text('addDuration(+1 hour)'),
          ),
        ],
      );
    },
  );
}
