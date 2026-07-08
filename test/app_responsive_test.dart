import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_responsive.dart';

void main() {
  group('ScaleCalculator', () {
    test('calculates width and height scale from design size', () {
      const calculator = ScaleCalculator(
        designSize: Size(360, 690),
        deviceSize: Size(720, 1380),
      );

      expect(calculator.scaleWidth, 2);
      expect(calculator.scaleHeight, 2);
      expect(calculator.width(100), 200);
      expect(calculator.height(50), 100);
    });

    test('minTextAdapt uses the smaller scale for text', () {
      const calculator = ScaleCalculator(
        designSize: Size(360, 690),
        deviceSize: Size(720, 1035),
        minTextAdapt: true,
      );

      expect(calculator.scaleWidth, 2);
      expect(calculator.scaleHeight, 1.5);
      expect(calculator.scaleText, 1.5);
      expect(calculator.sp(16), 24);
    });

    test('splitScreenMode uses configurable minimum height', () {
      const calculator = ScaleCalculator(
        designSize: Size(360, 690),
        deviceSize: Size(360, 500),
        splitScreenMode: true,
        splitScreenMinHeight: 700,
      );

      expect(calculator.scaleHeight, closeTo(700 / 690, 0.0001));
    });

    test('disabled scaling returns original values', () {
      const calculator = ScaleCalculator(
        designSize: Size(360, 690),
        deviceSize: Size(720, 1380),
        enableScaleWidth: false,
        enableScaleHeight: false,
        enableScaleText: false,
      );

      expect(calculator.scaleWidth, 1);
      expect(calculator.scaleHeight, 1);
      expect(calculator.scaleText, 1);
      expect(calculator.width(100), 100);
      expect(calculator.sp(16), 16);
    });

    test('radius diameter and diagonal use expected scales', () {
      const calculator = ScaleCalculator(
        designSize: Size(100, 200),
        deviceSize: Size(200, 400),
      );

      expect(calculator.radius(10), 20);
      expect(calculator.diameter(10), 20);
      expect(calculator.diagonal(2), 8);
    });
  });

  group('ScreenUtil integration', () {
    testWidgets('ScreenUtilInit exposes ResponsiveScope', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, child) => MaterialApp(home: child),
          child: Builder(
            builder: (context) {
              final scope = ResponsiveScope.maybeOf(context);
              expect(scope, isNotNull);
              expect(scope!.width(100), greaterThan(0));
              expect(100.w, scope.width(100));
              return const SizedBox();
            },
          ),
        ),
      );
    });

    test('portrait scaling uses shorter side in landscape', () {
      ScreenUtil.configure(
        data: const MediaQueryData(size: Size(800, 400)),
        designSize: const Size(360, 690),
      );

      final util = ScreenUtil.instance;
      expect(util.portraitWidth, 400);
      expect(util.portraitHeight, 800);
      expect(util.portraitSetWidth(100), closeTo(400 / 360 * 100, 0.01));
      expect(util.portraitSetHeight(100), closeTo(800 / 690 * 100, 0.01));
    });
  });

  group('RebuildFactors', () {
    test('sizeAndViewInsets reacts to size and inset changes', () {
      const oldData = MediaQueryData(size: Size(360, 690));
      const newSize = MediaQueryData(size: Size(400, 690));
      const newInsets = MediaQueryData(
        size: Size(360, 690),
        viewInsets: EdgeInsets.only(bottom: 300),
      );

      expect(RebuildFactors.sizeAndViewInsets(oldData, newSize), isTrue);
      expect(RebuildFactors.sizeAndViewInsets(oldData, newInsets), isTrue);
      expect(RebuildFactors.sizeAndViewInsets(oldData, oldData), isFalse);
    });
  });
}
