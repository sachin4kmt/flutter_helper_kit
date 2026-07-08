import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget boolExtensionsDemo(BuildContext context) {
  bool? flag;
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('null.validate()', '${flag.validate()}'),
      _Tile('true.isTrue()', '${true.isTrue()}'),
      _Tile('false.isFalse()', '${false.isFalse()}'),
      _Tile('true.toInt()', '${true.toInt()}'),
      _Tile('false.toggle()', '${false.toggle()}'),
    ],
  );
}

Widget intExtensionsDemo(BuildContext context) {
  const n = 42;
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('42.toWords()', n.toWords()),
      _Tile('2024.toRoman()', 2024.toRoman()),
      _Tile('3.toOrdinal()', 3.toOrdinal()),
      _Tile('5.seconds()', '${5.seconds()}'),
      _Tile('null.validate(10)', '${(null as int?).validate(10)}'),
      _Tile('7.addZeroPrefix()', '${7.addZeroPrefix()}'),
    ],
  );
}

Widget numExtensionsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('100.increaseByPercentage(10)', '${100.increaseByPercentage(10)}'),
      _Tile('50.isBetween(10, 60)', '${50.isBetween(10, 60)}'),
      _Tile('3.generateLoremIpsumWords()', '${3.generateLoremIpsumWords().substring(0, 40)}…'),
      _Tile('42.toNumeral', Numeral(42000).indian),
      12.height(),
      Row(children: [const Text('A'), 24.width(), const Text('B')]),
    ],
  );
}

Widget durationRandomScopeDemo(BuildContext context) {
  final rand = math.Random();
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('ScopeFunction.let', 'hello'.let((s) => s.toUpperCase())),
      _Tile('ScopeFunction.takeIf', '${5.takeIf((v) => v > 3)}'),
      _Tile('Random.generateLoremIpsumWords(5)', rand.generateLoremIpsumWords(5)),
      _Tile('Random.pastDate(30)', rand.pastDate(30).toString()),
      ElevatedButton(
        onPressed: () async {
          final start = DateTime.now();
          await const Duration(seconds: 1).delay();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('delay() took ${DateTime.now().difference(start).inMilliseconds}ms')),
            );
          }
        },
        child: const Text('Duration.delay() — wait 1s'),
      ),
    ],
  );
}

Widget widgetExtensionDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Container(color: Colors.teal, height: 48)
          .withWidth(200)
          .cornerRadiusWithClipRRect(12)
          .center()
          .paddingAll(8),
      const SizedBox(height: 12),
      const Text('WidgetExtension chain')
          .opacity(opacity: 0.7)
          .onTap(() {}),
      const SizedBox(height: 12),
      const Text('Hidden').visible(false, defaultWidget: Text('visible(false) → default')),
    ],
  );
}

Widget paddingBorderExtensionsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Container(
        padding: 16.padAll,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: 8.circularRadius,
        ),
        child: const Text('16.padAll + 8.borderRadiusAll'),
      ),
      const SizedBox(height: 12),
      const Text('Padded text').paddingSymmetric(horizontal: 24, vertical: 8),
      const SizedBox(height: 12),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: 12.circularSharpRadius,
        ),
        padding: const EdgeInsets.all(12),
        child: const Text('12.circularSharpRadius'),
      ),
    ],
  );
}

Widget setIterableExtensionsDemo(BuildContext context) {
  final set = {1, 2, 3, 4, 5};
  final items = ['a', 'bb', 'ccc'];
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('set.whereSet(even)', '${set.whereSet((e) => e.isEven)}'),
      _Tile('set.sorted()', '${set.sorted()}'),
      _Tile('items.groupBy(length)', '${items.groupBy((e) => e.length)}'),
      _Tile('items.maxBy(length)', '${items.maxBy((e) => e.length)}'),
      _Tile('nullable list.validate()', '${(null as List<int>?).validate()}'),
    ],
  );
}

Widget listenableExtensionsDemo(BuildContext context) {
  final counter = ValueNotifier(0);
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      counter.listen((v) => Text('ValueListenable.listen: $v', style: const TextStyle(fontSize: 18))),
      const SizedBox(height: 16),
      counter.builder(
        builder: (_, __) => ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment via Listenable.builder'),
        ),
      ),
    ],
  );
}

Widget rowColumnWidgetListDemo(BuildContext context) {
  final chips = ['One', 'Two', 'Three']
      .map((t) => Chip(label: Text(t)))
      .toList();
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 40, color: Colors.red.shade200)),
            Expanded(child: Container(height: 60, color: Colors.green.shade200)),
          ],
        ).intrinsicHeight(),
        const SizedBox(height: 16),
        Column(
          children: [
            Container(width: 80, height: 30, color: Colors.blue.shade200),
            Container(width: 120, height: 30, color: Colors.orange.shade200),
          ],
        ).intrinsicWidth(),
        const SizedBox(height: 16),
        Row(
          children: chips.expandEvery(),
        ),
      ],
    ),
  );
}

Widget mapExtensionDemo(BuildContext context) {
  final map = <String, int>{'a': 1, 'b': 2};
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('map.isNullOrEmpty', '${(map as Map<String, int>?).isNullOrEmpty}'),
      _Tile('map.getOrDefault("x", 0)', '${map.getOrDefault('x', 0)}'),
      _Tile('map.filter(>1)', '${map.filter((k, v) => v > 1)}'),
      _Tile('map.addIfNotNull("c", 3)', '${map.addIfNotNull('c', 3)}'),
    ],
  );
}

Widget colorExtensionsFullDemo(BuildContext context) {
  const color = Colors.blue;
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('color.toHex()', color.toHex()),
      _Tile('color.isDark()', '${color.isDark()}'),
      _Tile('color.lighten(0.2)', '${color.lighten(0.2)}'),
      _Tile('color.darken(0.2)', '${color.darken(0.2)}'),
      Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.green.createMaterialColor().shade400,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text('createMaterialColor'),
      ),
    ],
  );
}

Widget listNumExtensionDemo(BuildContext context) {
  final nums = [10, 20, 30];
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('nums.total', '${nums.total}'),
      _Tile('nums.isNotNullAndEmpty', '${nums.isNotNullAndEmpty}'),
      _Tile('null list.isNullAndEmpty', '${(null as List<num>?).isNullAndEmpty}'),
    ],
  );
}

Widget dateExtensionsDemo(BuildContext context) {
  final now = DateTime.now();
  final past = now.subtract(const Duration(days: 2));
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('past.isInPast', '${past.isInPast}'),
      _Tile('future.isInFuture', '${now.add(const Duration(days: 1)).isInFuture}'),
      _Tile('now.formatTime()', now.formatTime()),
      _Tile('now.timeZoneOffSet()', now.timeZoneOffSet()),
    ],
  );
}

class _Tile extends StatelessWidget {
  const _Tile(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        subtitle: Text(value),
      ),
    );
  }
}
