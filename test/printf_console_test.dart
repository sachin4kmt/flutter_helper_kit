import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/utils/console/printf_console.dart';

void main() {
  group('PrintfStyle', () {
    test('applyTo wraps ANSI codes when bold', () {
      const style = PrintfStyle(bold: true);
      final result = style.applyTo('hello');
      expect(result, contains('hello'));
      expect(result, startsWith('\x1B['));
      expect(result, endsWith('\x1B[0m'));
    });

    test('applyTo returns plain text when no flags', () {
      const style = PrintfStyle();
      expect(style.applyTo('plain'), 'plain');
    });

    test('preset styles are defined', () {
      expect(PrintfStyle.success.bold, isTrue);
      expect(PrintfStyle.error.foreground, Colors.red);
      expect(PrintfStyle.network.underline, isTrue);
    });
  });

  group('printfSeparator', () {
    test('builds labeled separator', () {
      final line = printfSeparator(object: 'TEST', length: 3);
      expect(line, '--- TEST ---');
    });

    test('builds plain line', () {
      expect(printfSeparator(length: 5), '-----');
    });
  });

  group('PrintfLevel', () {
    test('orders by priority', () {
      expect(
          PrintfLevel.error.priority, greaterThan(PrintfLevel.debug.priority));
      expect(
          PrintfLevel.warning.priority, greaterThan(PrintfLevel.info.priority));
    });
  });

  group('printf caller link', () {
    test('formats absolute file URI with line and column', () {
      const stack =
          '#0      main (file:///Users/me/project/lib/foo.dart:25:18)';
      expect(
        printfCallerLinkFromStackTrace(stack),
        'file:///Users/me/project/lib/foo.dart:25:18',
      );
    });

    test('formats unix absolute path as file URI', () {
      const stack =
          '#0      onTap (/Users/me/StudioProjects/app/lib/stats/stats_screen.dart:25:18)';
      expect(
        printfCallerLinkFromStackTrace(stack),
        'file:///Users/me/StudioProjects/app/lib/stats/stats_screen.dart:25:18',
      );
    });

    test('skips internal printf frames', () {
      const stack = '''
#0      _buildPrefix (package:flutter_helper_kit/utils/console/printf.dart:260:5)
#1      printf (package:flutter_helper_kit/utils/console/printf.dart:38:5)
#2      StatsController.load (file:///Users/me/project/lib/stats_controller.dart:144:7)
''';
      expect(
        printfCallerLinkFromStackTrace(stack),
        'file:///Users/me/project/lib/stats_controller.dart:144:7',
      );
    });

    test('skips printfBox wrapper to real caller', () {
      const stack = '''
#0      printf (package:flutter_helper_kit/utils/console/printf.dart:38:5)
#1      printfBox (package:flutter_helper_kit/utils/console/printf.dart:128:5)
#2      fetchData (/Users/me/lib/api.dart:88:5)
''';
      expect(
        printfCallerLinkFromStackTrace(stack),
        'file:///Users/me/lib/api.dart:88:5',
      );
    });
  });
}
