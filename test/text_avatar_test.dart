import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<Text> pumpAvatar(WidgetTester tester, TextAvatar avatar) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: Center(child: avatar))),
    );
    return tester.widget<Text>(find.byType(Text));
  }

  group('TextAvatar text color', () {
    testWidgets('uses seed tint when no override', (tester) async {
      const seed = Colors.red;
      final text = await pumpAvatar(
        tester,
        const TextAvatar(
          text: 'Ab',
          baseColor: seed,
          textOpacity: 0.8,
        ),
      );
      expect(text.style?.color, seed.withValues(alpha: 0.8));
    });

    testWidgets('respects style.color', (tester) async {
      final text = await pumpAvatar(
        tester,
        const TextAvatar(
          text: 'Ab',
          baseColor: Colors.red,
          backgroundOpacity: 1,
          textOpacity: 1,
          style: TextStyle(color: Colors.white),
        ),
      );
      expect(text.style?.color, Colors.white);
    });

    testWidgets('foregroundColor overrides style.color', (tester) async {
      final text = await pumpAvatar(
        tester,
        const TextAvatar(
          text: 'Ab',
          baseColor: Colors.red,
          foregroundColor: Colors.black,
          style: TextStyle(color: Colors.white),
        ),
      );
      expect(text.style?.color, Colors.black);
    });
  });
}
