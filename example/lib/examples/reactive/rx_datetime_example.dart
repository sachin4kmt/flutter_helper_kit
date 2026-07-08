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

Widget rxnDatetimeDemo(BuildContext context) {
  final rxn = RxnDateTime(DateTime.now().subtract(const Duration(days: 1)));
  return ValueListenableBuilder<DateTime?>(
    valueListenable: rxn,
    builder: (_, value, __) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('RxnDateTime.format(): ${rxn.format() ?? 'null'}'),
          Text('value is null: ${value == null}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => rxn.value = DateTime.now(),
            child: const Text('Set to now'),
          ),
          ElevatedButton(
            onPressed: () => rxn.value = null,
            child: const Text('Clear (null)'),
          ),
        ],
      );
    },
  );
}
