import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_extensions.dart';

void main() {
  group('StringMaskExtension', () {
    test('masks middle characters with custom start and end', () {
      expect(
        '9876543210'.mask(visibleStart: 2, visibleEnd: 4),
        '98****3210',
      );
      expect(
        '9876543210'.mask(visibleStart: 0, visibleEnd: 4),
        '******3210',
      );
      expect(
        '9876543210'.mask(visibleStart: 3, visibleEnd: 0),
        '987*******',
      );
    });

    test('returns empty string for null or empty input', () {
      expect((null as String?).mask(), '');
      expect(''.mask(), '');
    });

    test('returns original value when string is too short', () {
      expect('12'.mask(visibleStart: 2, visibleEnd: 2), '12');
    });

    test('masks short strings when maskIfShorter is true', () {
      expect(
          '12'.mask(visibleStart: 2, visibleEnd: 2, maskIfShorter: true), '**');
    });

    test('supports custom mask character', () {
      expect(
        '9876543210'.mask(visibleStart: 2, visibleEnd: 4, maskChar: '#'),
        '98####3210',
      );
    });
  });

  group('PhoneMaskExtension', () {
    test('masks phone with custom visible start and end', () {
      expect(
        '9876543210'.maskPhone(visibleStart: 2, visibleEnd: 4),
        '98****3210',
      );
      expect(
        '+919876543210'.maskPhone(visibleStart: 3, visibleEnd: 4),
        '+919*****3210',
      );
    });

    test('strips non-digit characters before masking', () {
      expect(
        '98765-43210'.maskPhone(visibleStart: 2, visibleEnd: 4),
        '98****3210',
      );
      expect(
        '+91 98765 43210'.maskPhone(visibleStart: 2, visibleEnd: 4),
        '+91******3210',
      );
    });

    test('can hide plus prefix', () {
      expect(
        '+919876543210'.maskPhone(
          visibleStart: 2,
          visibleEnd: 4,
          keepPlusPrefix: false,
        ),
        '91******3210',
      );
    });

    test('supports separator formatting', () {
      expect(
        '9876543210'.maskPhone(
          visibleStart: 2,
          visibleEnd: 4,
          separator: ' ',
        ),
        '98 ** ** 32 10',
      );
    });
  });

  group('EmailMaskExtension', () {
    test('masks local part with custom visible start and end', () {
      expect(
        'user@example.com'.maskEmail(visibleStart: 1, visibleEnd: 0),
        'u***@example.com',
      );
      expect(
        'john.doe@gmail.com'.maskEmail(visibleStart: 2, visibleEnd: 2),
        'jo****oe@gmail.com',
      );
    });

    test('can mask domain when requested', () {
      expect(
        'sachin@company.co.in'.maskEmail(
          visibleStart: 2,
          visibleEnd: 1,
          maskDomain: true,
          domainVisibleStart: 2,
          domainVisibleEnd: 4,
        ),
        'sa***n@co*******o.in',
      );
    });

    test('falls back to generic mask for invalid email', () {
      expect(
        'notanemail'.maskEmail(visibleStart: 1, visibleEnd: 1),
        'n********l',
      );
    });
  });
}
