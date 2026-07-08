import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/extensions/alignment/alignment.dart';

void main() {
  group('AlignmentAxis', () {
    test('uses epsilon for center detection', () {
      expect(verticalAxisOf(0), AlignmentVertical.center);
      expect(verticalAxisOf(1e-12), AlignmentVertical.center);
      expect(horizontalAxisOf(0), AlignmentHorizontal.center);
    });
  });

  group('AlignmentExtensions', () {
    test('detects vertical and horizontal buckets', () {
      expect(Alignment.topCenter.isTop, isTrue);
      expect(Alignment.topCenter.isCenterHorizontal, isTrue);
      expect(Alignment.bottomRight.isBottom, isTrue);
      expect(Alignment.bottomRight.isRight, isTrue);
      expect(Alignment.center.isCenter, isTrue);
      expect(Alignment.centerLeft.isEdge, isTrue);
      expect(Alignment.topLeft.isCorner, isTrue);
    });

    test('mirrors and combines alignments', () {
      expect(Alignment.topLeft.opposite, Alignment.bottomRight);
      expect(Alignment.centerLeft.flipX, Alignment.centerRight);
      expect(
        Alignment.topLeft.combineWith(Alignment.bottomRight),
        Alignment.center,
      );
    });
  });

  group('AlignmentGeometryExtensions', () {
    test('resolves directional geometry for LTR and RTL', () {
      const geometry = AlignmentDirectional.topStart;

      expect(
        geometry.isTopResolved(TextDirection.ltr),
        isTrue,
      );
      expect(
        geometry.isLeftResolved(TextDirection.ltr),
        isTrue,
      );
      expect(
        geometry.isRightResolved(TextDirection.rtl),
        isTrue,
      );
    });
  });

  group('AlignmentDirectionalExtensions', () {
    test('detects start/end before resolve', () {
      expect(AlignmentDirectional.topStart.isStart, isTrue);
      expect(AlignmentDirectional.topEnd.isEnd, isTrue);
      expect(AlignmentDirectional.center.isCenter, isTrue);
    });
  });
}
