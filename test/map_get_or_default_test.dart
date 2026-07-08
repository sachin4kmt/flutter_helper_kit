import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_extensions.dart';

void main() {
  final apiMap = <String, dynamic>{
    'name': ' Sachin ',
    'avatar_url': 'https://example.com/a.png',
    'count': '42',
    'price': '19.50',
    'active': 'yes',
    'disabled': 'off',
    'created_at': 1700000000,
    'starts_at': '13:45',
    'theme': '#172554',
    'meta': '{"role":"admin"}',
    'tags': ['a', 'b'],
    'user_id': 99,
    'legacy_name': 'Legacy User',
  };

  group('MapGetOrDefault API parsing', () {
    test('parses strings with alternative keys', () {
      expect(apiMap.getApiStringOrDefault('missing'), isNull);
      expect(
        apiMap.getApiStringOrDefault(
          'name',
          alternativeKeys: ['legacy_name'],
        ),
        'Sachin',
      );
      expect(
        apiMap.getApiStringOrDefault(
          'missing',
          defaultValue: 'Guest',
          alternativeKeys: ['legacy_name'],
        ),
        'Legacy User',
      );
    });

    test('validates API URLs', () {
      expect(
        apiMap.getApiUrlStringOrDefault('avatar_url'),
        'https://example.com/a.png',
      );
      expect(
        apiMap.getApiUrlStringOrDefault('name', defaultValue: 'fallback'),
        'fallback',
      );
    });

    test('parses numeric and bool values', () {
      expect(apiMap.getApiIntOrDefault('count'), 42);
      expect(apiMap.getApiNumOrDefault('price'), 19.5);
      expect(apiMap.getApiBoolOrDefault('active'), isTrue);
      expect(apiMap.getApiBoolOrDefault('disabled'), isFalse);
    });

    test('parses date time epoch seconds and time of day', () {
      final date = apiMap.getApiDateTimeOrDefault('created_at');
      expect(date, isNotNull);
      expect(date!.millisecondsSinceEpoch, 1700000000000);

      expect(
        apiMap.getApiTimeOfDayOrDefault('starts_at'),
        const TimeOfDay(hour: 13, minute: 45),
      );
    });

    test('parses nested map json and lists', () {
      expect(apiMap.getApiMapObject('meta'), {'role': 'admin'});
      expect(apiMap.getApiListOrDefault<String>('tags'), ['a', 'b']);
      expect(apiMap.getApiObjectOrDefault<int>('user_id'), 99);
    });

    test('parses hex colors', () {
      expect(
        apiMap.getApiColorOrDefault('theme'),
        const Color(0xFF172554),
      );
    });

    test('map helpers merge and exclude keys', () {
      final updated = apiMap.addKeyValue('status', 'ok');
      expect(updated['status'], 'ok');

      final merged = apiMap.addKeyWithExcludeKeys(
        {'status': 'ok', 'name': 'Override'},
        excludeKeys: ['name'],
      );
      expect(merged['status'], 'ok');
      expect(merged['name'], ' Sachin ');

      final filtered = apiMap.excludeKeys(['tags', 'meta']);
      expect(filtered.containsKey('tags'), isFalse);
      expect(filtered.containsKey('name'), isTrue);
    });
  });
}
