import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget host(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  group('Space', () {
    testWidgets('uses a fixed main-axis extent in a Row', (tester) async {
      const key = Key('space');
      await tester.pumpWidget(
        host(
          const SizedBox(
            width: 100,
            child: Row(
              children: [
                Space(24, key: key),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byKey(key)).width, 24);
    });
  });

  group('SpaceMax', () {
    testWidgets('caps its extent and can shrink', (tester) async {
      const key = Key('space-max');
      await tester.pumpWidget(
        host(
          const SizedBox(
            width: 200,
            child: Row(
              children: [
                SizedBox(width: 50),
                SpaceMax(20, key: key),
                SizedBox(width: 50),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byKey(key)).width, 20);
    });
  });

  group('SpaceMin', () {
    testWidgets('expands when max is omitted', (tester) async {
      const key = Key('space-min-expand');
      await tester.pumpWidget(
        host(
          const SizedBox(
            width: 200,
            child: Row(
              children: [
                SizedBox(width: 20),
                SpaceMin(min: 10, key: key),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byKey(key)).width, 160);
    });

    testWidgets('is capped when max is provided', (tester) async {
      const key = Key('space-min-capped');
      await tester.pumpWidget(
        host(
          const SizedBox(
            width: 200,
            child: Row(
              children: [
                SizedBox(width: 20),
                SpaceMin(min: 10, max: 30, key: key),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byKey(key)).width, 30);
    });

    testWidgets('supports a direct Scrollable child', (tester) async {
      const key = Key('space-min-scroll');
      await tester.pumpWidget(
        host(
          SizedBox(
            width: 200,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SpaceMin(min: 10, max: 30, key: key),
              ],
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byKey(key)).width, 30);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('SliverSpace contributes its fixed scroll extent',
      (tester) async {
    const key = Key('sliver-space');
    await tester.pumpWidget(
      host(
        const SizedBox(
          height: 100,
          child: CustomScrollView(
            slivers: [
              SliverSpace(24, key: key),
            ],
          ),
        ),
      ),
    );

    final renderObject =
        tester.renderObject<RenderSliverSpace>(find.byKey(key));
    expect(renderObject.geometry?.scrollExtent, 24);
  });
}
