part of 'printf_console.dart';

/// ANSI styling for [printf] output.
///
/// Some terminals/IDEs may not render every style. See
/// [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code).
class PrintfStyle {
  const PrintfStyle({
    this.foreground,
    this.background,
    this.italic = false,
    this.bold = false,
    this.underline = false,
    this.invert = false,
    this.strike = false,
    this.doubleUnderline = false,
    this.framed = false,
  });

  final Color? foreground;
  final Color? background;
  final bool italic;
  final bool bold;
  final bool underline;
  final bool invert;
  final bool strike;
  final bool doubleUnderline;
  final bool framed;

  /// Green bold text — success messages.
  static const success = PrintfStyle(
    foreground: Colors.green,
    bold: true,
  );

  /// Red bold text — errors.
  static const error = PrintfStyle(
    foreground: Colors.red,
    bold: true,
  );

  /// Orange bold text — warnings.
  static const warning = PrintfStyle(
    foreground: Colors.orange,
    bold: true,
  );

  /// Blue text — informational logs.
  static const info = PrintfStyle(
    foreground: Colors.blue,
  );

  /// Grey italic text — debug noise.
  static const debug = PrintfStyle(
    foreground: Colors.grey,
    italic: true,
  );

  /// Cyan underline — network / API logs.
  static const network = PrintfStyle(
    foreground: Colors.cyan,
    underline: true,
  );

  PrintfStyle copyWith({
    Color? foreground,
    Color? background,
    bool? italic,
    bool? bold,
    bool? underline,
    bool? invert,
    bool? strike,
    bool? doubleUnderline,
    bool? framed,
  }) {
    return PrintfStyle(
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      italic: italic ?? this.italic,
      bold: bold ?? this.bold,
      underline: underline ?? this.underline,
      invert: invert ?? this.invert,
      strike: strike ?? this.strike,
      doubleUnderline: doubleUnderline ?? this.doubleUnderline,
      framed: framed ?? this.framed,
    );
  }

  /// Wraps [text] with ANSI escape sequences for the active style flags.
  String applyTo(String text) {
    final codes = <String>[];
    if (bold) codes.add('1');
    if (italic) codes.add('3');
    if (underline) codes.add('4');
    if (invert) codes.add('7');
    if (strike) codes.add('9');
    if (doubleUnderline) codes.add('21');
    if (framed) codes.add('51');
    if (foreground != null) {
      codes.add('38;2;${_rgb(foreground!)}');
    }
    if (background != null) {
      codes.add('48;2;${_rgb(background!)}');
    }
    if (codes.isEmpty) return text;
    return '\x1B[${codes.join(';')}m$text\x1B[0m';
  }

  static String _rgb(Color color) {
    return '${_channel(color.r)};${_channel(color.g)};${_channel(color.b)}';
  }

  static int _channel(double value) => (value * 255).round().clamp(0, 255);
}

/// Log severity used by [printf] and shortcuts like [printfError].
enum PrintfLevel {
  debug(0, 'DEBUG', PrintfStyle.debug),
  info(1, 'INFO', PrintfStyle.info),
  success(2, 'OK', PrintfStyle.success),
  warning(3, 'WARN', PrintfStyle.warning),
  error(4, 'ERROR', PrintfStyle.error);

  const PrintfLevel(this.priority, this.label, this.defaultStyle);

  final int priority;
  final String label;
  final PrintfStyle defaultStyle;
}

/// Global behaviour for printf helpers.
class PrintfConfig {
  PrintfConfig._();

  /// Master switch for all printf output.
  static bool enabled = true;

  /// When `true`, output is suppressed outside [kDebugMode].
  static bool onlyInDebugMode = true;

  /// Default timestamp prefix for every log line.
  static bool showTimestamp = false;

  /// Default caller `file://` link to the [printf] call site (IDE-clickable).
  static bool showCaller = true;

  /// When `true`, caller links use `file:///absolute/path.dart:line:column`.
  /// When `false`, uses the raw URI from the stack frame (`package:` etc.).
  static bool useFileUriLinks = true;

  /// Minimum level to print. Logs below this are ignored.
  static PrintfLevel minLevel = PrintfLevel.debug;

  /// Name passed to `dart:developer` [developer.log].
  static String logName = 'printf';
}
