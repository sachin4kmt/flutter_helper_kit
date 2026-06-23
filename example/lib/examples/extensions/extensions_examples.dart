import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget stringExtensionsDemo(BuildContext context) {
  const input = 'edit_item_name';
  final phone = 'call 9799408400 now'.extractPhoneNumber();
  final results = {
    'toSnakeCase()': input.toSnakeCase(),
    'toCamelCase()': 'edit item'.toCamelCase(),
    'toPascalCase()': 'edit item'.toPascalCase(),
    'toTitleCase()': input.toTitleCase(),
    'isValidateEmail()': '${'test@mail.com'.isValidateEmail()}',
    'extractPhoneNumber()': phone.toString(),
    'isEmptyOrNull': '${''.isEmptyOrNull}',
    'passwordStrength()': 'Abc123!@'.passwordStrength(),
  };

  return ListView(
    padding: const EdgeInsets.all(16),
    children: results.entries
        .map(
          (e) => Card(
            child: ListTile(
              title: Text(e.key, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              subtitle: Text('→ ${e.value}'),
            ),
          ),
        )
        .toList(),
  );
}

Widget numberExtensionsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ResultTile('1.50.toStringAsSmartRounded()', 1.50.toStringAsSmartRounded()),
      _ResultTile('2.00.toStringAsSmartRounded()', 2.00.toStringAsSmartRounded()),
      _ResultTile('16.height()', 'SizedBox widget'),
      16.height(),
    ],
  );
}

Widget colorDateExtensionsDemo(BuildContext context) {
  final now = DateTime.now().subtract(const Duration(hours: 3));
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Container(
        height: 48,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.blue.withColorOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text('Colors.blue.withColorOpacity(0.6)'),
      ),
      _ResultTile('DateTime.timeAgo()', now.timeAgo()),
      _ResultTile('DateTime.format()', now.format(pattern: 'dd MMM yyyy')),
    ],
  );
}

Widget listMapExtensionsDemo(BuildContext context) {
  final list = [1, 2, 3];
  final map = {'a': 1, 'b': 2};
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ResultTile('list.firstOrNull', '${list.isNotEmpty ? list.first : null}'),
      _ResultTile('map.getOrDefault', '${map.getOrDefault('x', 0)}'),
      _ResultTile('List?.validate()', '${(null as List<int>?).validate()}'),
    ],
  );
}

Widget widgetContextExtensionsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Center(child: const Text('Hello').paddingAll(12)),
      const SizedBox(height: 12),
      ElevatedButton(
        onPressed: () => context.showSnackBar(title: const Text('context.showSnackBar()')),
        child: const Text('Show SnackBar'),
      ),
      const SizedBox(height: 8),
      Text('Screen: ${context.width} x ${context.height}'),
    ],
  );
}

Widget typeConversionDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ResultTile("'42'.toInt()", '${('42' as Object?).toInt()}'),
      _ResultTile("'true'.toBool()", '${('true' as Object?).toBool()}'),
      _ResultTile("'3.14'.toDouble()", '${('3.14' as Object?).toDouble()}'),
    ],
  );
}

Widget alignmentExtensionsDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _ResultTile('Alignment.topCenter.isTop', '${Alignment.topCenter.isTop}'),
      _ResultTile('Alignment.center.isCenterVertical', '${Alignment.center.isCenterVertical}'),
      _ResultTile('Alignment.bottomRight.isRight', '${Alignment.bottomRight.isRight}'),
    ],
  );
}

class _ResultTile extends StatelessWidget {
  const _ResultTile(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
        subtitle: Text('→ $value'),
      ),
    );
  }
}
