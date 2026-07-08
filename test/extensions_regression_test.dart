import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_extensions.dart';

void main() {
  group('DateTimeExtension regressions', () {
    test('weekdayName uses weekday not day of month', () {
      final saturday = DateTime(2025, 3, 15);
      expect(saturday.weekday, DateTime.saturday);
      expect(saturday.weekdayName(), 'Saturday');
      expect(saturday.weekdayName(isHalfName: true), 'Sat');
    });

    test('isYesterday works across month boundary', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isYesterday(), isTrue);
    });

    test('isTomorrow works across month boundary', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      expect(tomorrow.isTomorrow(), isTrue);
    });

    test('currentTimeStamp uses instance value', () {
      final past = DateTime(2020, 1, 1, 12);
      expect(
        past.currentTimeStamp(),
        past.millisecondsSinceEpoch ~/ 1000,
      );
    });

    test('previousMonth and nextMonth preserve day and time', () {
      final date = DateTime(2024, 3, 15, 10, 30, 5);
      final previous = date.previousMonth();
      final next = date.nextMonth();

      expect(previous, DateTime(2024, 2, 15, 10, 30, 5));
      expect(next, DateTime(2024, 4, 15, 10, 30, 5));
    });
  });

  group('MapExtension regressions', () {
    test('updateAndJoin merges maps without mutating original', () {
      final map1 = {'a': 1, 'b': 2};
      final map2 = {'b': 3, 'c': 4};

      final merged = map1.updateAndJoin(map2);

      expect(merged, {'a': 1, 'b': 3, 'c': 4});
      expect(map1, {'a': 1, 'b': 2});
      expect(map2, {'b': 3, 'c': 4});
    });
  });

  group('ListExtension regressions', () {
    test('separatorEvery inserts separator between items', () {
      expect([1, 2, 3].separatorEvery(0), [1, 0, 2, 0, 3]);
    });

    test('separatorEvery supports start and end separators', () {
      expect(
        [1, 2, 3].separatorEvery(0, start: true, end: true),
        [0, 1, 0, 2, 0, 3, 0],
      );
    });
  });

  group('ListnumManipulation regressions', () {
    test('isNullAndEmpty handles null without crashing', () {
      List<num>? nullList;
      expect(nullList.isNullAndEmpty, isTrue);
      expect(<num>[].isNullAndEmpty, isTrue);
      expect(<num>[1].isNullAndEmpty, isFalse);
    });
  });

  group('IntNullableExtensions regressions', () {
    test('microseconds returns microsecond duration', () {
      expect(5.microseconds(), const Duration(microseconds: 5));
    });
  });

  group('StringExtension regressions', () {
    test('capitalizeEachWordFirstCharacter capitalizes every word', () {
      expect(
        'hello world'.capitalizeEachWordFirstCharacter(),
        'Hello World',
      );
    });
  });

  group('NumExt regressions', () {
    test('percentageDifference avoids divide by zero', () {
      expect(0.percentageDifference(10), isNull);
      expect(100.percentageDifference(120), 20);
    });

    test('randomList handles equal min and max', () {
      expect(3.randomList(min: 5, max: 5), [5, 5, 5]);
    });
  });
}
