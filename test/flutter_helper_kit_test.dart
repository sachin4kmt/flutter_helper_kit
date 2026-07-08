import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

void main() {
  group('StringCaseExtensions', () {
    test('converts to snake_case', () {
      expect('EditItem'.toSnakeCase(), 'edit_item');
    });

    test('converts to camelCase', () {
      expect('edit item'.toCamelCase(), 'editItem');
    });
  });

  group('PasswordStrengthExtension', () {
    test('rates password strength', () {
      expect('abc'.passwordStrength(), 'Weak');
      expect('Abc123'.passwordStrength(), isNot('Weak'));
    });
  });

  group('ConversionExtension', () {
    test('toInt parses strings', () {
      expect('42'.toInt(), 42);
      expect(('x' as Object?).toInt(defaultValue: 0), 0);
    });

    test('toBool parses common values', () {
      expect('true'.toBool(), isTrue);
      expect('off'.toBool(), isFalse);
    });
  });

  group('SmartRoundExtension', () {
    test('trims trailing zeros', () {
      expect(1.50.toStringAsSmartRounded(), '1.5');
      expect(2.00.toStringAsSmartRounded(), '2');
    });
  });

  group('AlignmentExtensions', () {
    test('detects top alignment', () {
      expect(Alignment.topCenter.isTop, isTrue);
      expect(Alignment.center.isCenterVertical, isTrue);
    });
  });

  group('RxDateTime', () {
    test('formats and compares dates', () {
      final rx = RxDateTime(DateTime(2024, 6, 15, 10, 30));
      expect(rx.format('yyyy-MM-dd'), '2024-06-15');
      expect(rx.isBefore(DateTime(2025)), isTrue);
    });

    test('addDuration updates value', () {
      final rx = RxDateTime(DateTime(2024, 1, 1, 10));
      rx.addDuration(const Duration(hours: 2));
      expect(rx.value.hour, 12);
    });
  });

  group('RandomPicsumImage', () {
    test('builds image url', () {
      expect(
        RandomPicsumImage.image(width: 200, height: 100),
        'https://picsum.photos/200/100',
      );
    });
  });

  group('MapCustomInfoWindow', () {
    test('controller disposes cleanly', () {
      final controller = MapCustomInfoWindowController();
      controller.dispose();
      expect(controller.addInfoWindow, isNull);
    });
  });

  group('CallbackMapInfoWindowAdapter', () {
    test('delegates to callback', () async {
      final adapter = CallbackMapInfoWindowAdapter(
        onGetScreenCoordinate: (latLng) async => MapScreenCoordinate(
            (latLng.latitude * 10).toInt(), (latLng.longitude * 10).toInt()),
      );
      final result =
          await adapter.getScreenCoordinate(const MapLatLng(12.5, 77.5));
      expect(result.x, 125);
      expect(result.y, 775);
    });
  });

  group('ScreenUtil', () {
    testWidgets('initializes with design size', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, child) => MaterialApp(home: child),
          child: Builder(
            builder: (context) {
              expect(100.w, greaterThan(0));
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('PasswordStrengthIndicator', () {
    testWidgets('renders with controller', (tester) async {
      final controller = TextEditingController(text: 'Abc123!@');
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(textController: controller),
          ),
        ),
      );

      expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
    });
  });

  group('SliderButton', () {
    testWidgets('renders label', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, child) => MaterialApp(home: Scaffold(body: child)),
          child: SliderButton(
            action: () async => false,
            label: const Text('Slide'),
            width: 300,
            height: 60,
          ),
        ),
      );

      expect(find.text('Slide'), findsOneWidget);
    });
  });

  group('CenterTextDivider', () {
    testWidgets('renders custom paint', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, child) => MaterialApp(home: Scaffold(body: child)),
          child: CenterTextDivider.text(label: 'OR'),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    });
  });

  group('AnimateOnWidget', () {
    testWidgets('skips animation when disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: const Text('Hello').animateWidgetElasticEntry(animate: false),
          ),
        ),
      );

      expect(find.text('Hello'), findsOneWidget);
    });
  });

  group('TicketClipper', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: TicketClipper(
            clipper: PointedEdgeClipper(),
            child: Container(height: 100, color: Colors.blue),
          ),
        ),
      );

      expect(find.byType(TicketClipper), findsOneWidget);
    });
  });

  group('ListNullExtension', () {
    test('validate returns empty list for null', () {
      List<int>? list;
      expect(list.validate(), isEmpty);
    });
  });
}
