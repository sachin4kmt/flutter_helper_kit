part of 'printf_console.dart';

/// Prints [data] to the console with optional ANSI styling, tags, and metadata.
///
/// Pretty-prints [Map]/[List] and JSON strings. Use [mapKey] or [listIndex]
/// to drill into nested structures before printing.
///
/// ```dart
/// printf({'user': 'Ada'}, tag: 'AUTH', level: PrintfLevel.success);
/// printfError('Token expired');
/// printfSeparator(object: 'BOOT');
/// ```
void printf(
  Object? data, {
  Object? mapKey,
  int? listIndex,
  String? tag,
  PrintfLevel level = PrintfLevel.debug,
  Color? foreground,
  Color? background,
  bool italic = false,
  bool bold = false,
  bool underline = false,
  bool invert = false,
  bool strike = false,
  bool doubleUnderline = false,
  bool framed = false,
  bool? timestamp,
  bool? showFile,
  PrintfStyle? style,
  String? name,
  int stackTraceIndex = 1,
}) {
  if (!_shouldPrint(level)) return;

  final resolved = _resolvePayload(data, mapKey: mapKey, listIndex: listIndex);
  final message = _formatPayload(resolved);
  final prefix = _buildPrefix(
    level: level,
    tag: tag,
    timestamp: timestamp ?? PrintfConfig.showTimestamp,
    showFile: showFile ?? PrintfConfig.showCaller,
    stackTraceIndex: stackTraceIndex,
  );

  final appliedStyle = style ??
      (foreground != null ||
              background != null ||
              italic ||
              bold ||
              underline ||
              invert ||
              strike ||
              doubleUnderline ||
              framed
          ? PrintfStyle(
              foreground: foreground,
              background: background,
              italic: italic,
              bold: bold,
              underline: underline,
              invert: invert,
              strike: strike,
              doubleUnderline: doubleUnderline,
              framed: framed,
            )
          : level.defaultStyle);

  developer.log(
    '$prefix${appliedStyle.applyTo(message)}',
    name: name ?? PrintfConfig.logName,
    level: _developerLevel(level),
    stackTrace: _callerStackTrace(stackTraceIndex),
  );
}

void printfDebug(Object? data, {String? tag, PrintfStyle? style}) =>
    printf(data, tag: tag, level: PrintfLevel.debug, style: style);

void printfInfo(Object? data, {String? tag, PrintfStyle? style}) =>
    printf(data, tag: tag, level: PrintfLevel.info, style: style);

void printfSuccess(Object? data, {String? tag, PrintfStyle? style}) =>
    printf(data, tag: tag, level: PrintfLevel.success, style: style);

void printfWarn(Object? data, {String? tag, PrintfStyle? style}) =>
    printf(data, tag: tag, level: PrintfLevel.warning, style: style);

void printfError(
  Object? data, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
  PrintfStyle? style,
}) {
  printf(
    data,
    tag: tag,
    level: PrintfLevel.error,
    style: style ?? PrintfStyle.error,
  );
  if (error != null) {
    printf(error, tag: tag, level: PrintfLevel.error, style: PrintfStyle.error);
  }
  if (stackTrace != null) {
    printf(
      stackTrace,
      tag: tag,
      level: PrintfLevel.error,
      style: const PrintfStyle(foreground: Colors.red, italic: true),
    );
  }
}

/// Horizontal rule with optional label — useful to group logs.
String printfSeparator({Object object = '', int length = 20}) {
  final line = List.filled(length, '-').join();
  return object.toString().isEmpty ? line : '$line $object $line';
}

/// Prints a titled box around [message].
void printfBox(
  String title,
  Object? message, {
  PrintfLevel level = PrintfLevel.info,
  String? tag,
}) {
  final body = _formatPayload(message);
  printf(
    '${printfSeparator(object: title, length: 12)}\n$body\n${printfSeparator(length: 40)}',
    tag: tag,
    level: level,
    timestamp: true,
  );
}

/// Prints key/value rows in a aligned block.
void printfTable(
  Map<String, Object?> rows, {
  String? title,
  PrintfLevel level = PrintfLevel.debug,
  String? tag,
}) {
  if (rows.isEmpty) {
    printf('(empty table)', tag: tag, level: level);
    return;
  }
  final width = rows.keys.map((k) => k.length).reduce((a, b) => a > b ? a : b);
  final buffer = StringBuffer();
  if (title != null && title.isNotEmpty) {
    buffer.writeln(printfSeparator(object: title, length: 10));
  }
  rows.forEach((key, value) {
    buffer.writeln('${key.padRight(width)} : $value');
  });
  printf(buffer.toString().trimRight(),
      tag: tag, level: level, timestamp: true);
}

/// Logs an outgoing HTTP request without coupling to `http` or `dio`.
void printHttpRequest({
  required String method,
  required String url,
  Map<String, Object?>? headers,
  Object? body,
  Iterable<String>? files,
  String? tag = 'HTTP',
}) {
  printfBox(
    '$method REQUEST',
    [
      'URL     : $url',
      if (headers != null && headers.isNotEmpty) 'HEADERS : $headers',
      if (body != null) 'BODY    : ${_formatPayload(body)}',
      if (files != null && files.isNotEmpty) 'FILES   : ${files.join(', ')}',
    ].join('\n'),
    level: PrintfLevel.info,
    tag: tag,
  );
}

/// Logs an HTTP response summary.
void printHttpResponse({
  required String method,
  required String url,
  required int statusCode,
  bool? success,
  Object? body,
  Duration? duration,
  String? tag = 'HTTP',
}) {
  final ok = success ?? (statusCode >= 200 && statusCode < 300);
  final level = ok ? PrintfLevel.success : PrintfLevel.error;
  final statusIcon = ok ? '✅' : '❌';
  printf(
    [
      printfSeparator(object: '$method RESPONSE', length: 14),
      '$statusIcon $statusCode  $url',
      if (duration != null) 'TIME : ${duration.inMilliseconds}ms',
      if (body != null) 'BODY : ${_formatPayload(body)}',
      printfSeparator(length: 40),
    ].join('\n'),
    tag: tag,
    level: level,
    style: PrintfStyle.network,
    timestamp: true,
  );
}

bool _shouldPrint(PrintfLevel level) {
  if (!PrintfConfig.enabled) return false;
  if (PrintfConfig.onlyInDebugMode && !kDebugMode) return false;
  return level.priority >= PrintfConfig.minLevel.priority;
}

Object? _resolvePayload(
  Object? data, {
  Object? mapKey,
  int? listIndex,
}) {
  var obj = data;
  if (mapKey != null && data is Map) {
    obj = data[mapKey];
  }
  if (listIndex != null && data is List) {
    RangeError.checkValidIndex(listIndex, data, 'listIndex');
    obj = data[listIndex];
  }
  return obj;
}

String _formatPayload(Object? obj) {
  if (obj == null) return 'null';
  if (obj is Map || obj is List) {
    try {
      return const JsonEncoder.withIndent('  ').convert(obj);
    } catch (_) {
      return obj.toString();
    }
  }
  if (_isJsonString(obj)) {
    try {
      final decoded = jsonDecode(obj as String);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return obj.toString();
    }
  }
  return obj.toString();
}

bool _isJsonString(Object? value) {
  if (value is! String) return false;
  final trimmed = value.trim();
  return (trimmed.startsWith('{') && trimmed.endsWith('}')) ||
      (trimmed.startsWith('[') && trimmed.endsWith(']'));
}

String _buildPrefix({
  required PrintfLevel level,
  String? tag,
  required bool timestamp,
  required bool showFile,
  required int stackTraceIndex,
}) {
  final parts = <String>[];

  if (showFile) {
    final link = _callerLinkFromStackTrace(
      StackTrace.current.toString(),
      extraSkip: stackTraceIndex,
    );
    if (link != null) {
      parts.add('$link ');
    }
  }

  if (timestamp) {
    final time = DateTime.now();
    parts.add(
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}:'
      '${time.second.toString().padLeft(2, '0')}.'
      '${time.millisecond.toString().padLeft(3, '0')} ',
    );
  }
  parts.add('[${level.label}] ');
  if (tag != null && tag.isNotEmpty) {
    parts.add('[$tag] ');
  }
  return parts.join();
}

class _FrameLocation {
  const _FrameLocation(this.path, this.line, this.column);

  final String path;
  final int line;
  final int column;
}

String? _callerLinkFromStackTrace(
  String stackTraceText, {
  int extraSkip = 0,
}) {
  final frames = stackTraceText.split('\n');
  var skipped = 0;
  for (final frame in frames) {
    final trimmed = frame.trim();
    if (trimmed.isEmpty) continue;
    if (_isPrintfInternalFrame(trimmed)) continue;
    if (skipped < extraSkip) {
      skipped++;
      continue;
    }
    final location = _parseFrameLocation(trimmed);
    if (location == null) continue;
    return _toClickableUri(location);
  }
  return null;
}

StackTrace? _callerStackTrace(int extraSkip) {
  final frames = <String>[];
  var skipped = 0;
  for (final frame in StackTrace.current.toString().split('\n')) {
    final trimmed = frame.trim();
    if (trimmed.isEmpty) continue;
    if (_isPrintfInternalFrame(trimmed)) continue;
    if (skipped < extraSkip) {
      skipped++;
      continue;
    }
    frames.add(trimmed);
    if (frames.length >= 8) break;
  }
  if (frames.isEmpty) return null;
  return StackTrace.fromString(frames.join('\n'));
}

bool _isPrintfInternalFrame(String frame) {
  if (frame.contains('console/printf.dart') ||
      frame.contains('console/printf_console.dart') ||
      frame.contains('console/printf_style.dart')) {
    return true;
  }

  final fnMatch = RegExp(r'^#\d+\s+([^\s(]+)').firstMatch(frame);
  if (fnMatch == null) return false;
  const internalNames = {
    'printf',
    'printfDebug',
    'printfInfo',
    'printfSuccess',
    'printfWarn',
    'printfError',
    'printfBox',
    'printfTable',
    'printHttpRequest',
    'printHttpResponse',
    '_buildPrefix',
    '_callerLinkFromStackTrace',
    '_callerStackTrace',
    '_shouldPrint',
    '_resolvePayload',
    '_formatPayload',
  };
  return internalNames.contains(fnMatch.group(1));
}

_FrameLocation? _parseFrameLocation(String frame) {
  final patterns = [
    RegExp(r'\(([^)]+):(\d+):(\d+)\)'),
    RegExp(r' ([^ ]+):(\d+):(\d+)$'),
  ];
  for (final pattern in patterns) {
    final match = pattern.firstMatch(frame);
    if (match == null) continue;
    final path = match.group(1)!.trim();
    if (path.isEmpty) continue;
    return _FrameLocation(
      path,
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
  }
  return null;
}

String _toClickableUri(_FrameLocation location) {
  var path = location.path;
  if (path.startsWith('file://')) {
    path = path.substring('file://'.length);
  }

  if (PrintfConfig.useFileUriLinks && path.startsWith('/')) {
    return 'file://$path:${location.line}:${location.column}';
  }

  if (path.startsWith('package:') || path.startsWith('/')) {
    return '$path:${location.line}:${location.column}';
  }

  return '$path:${location.line}:${location.column}';
}

int _developerLevel(PrintfLevel level) {
  switch (level) {
    case PrintfLevel.debug:
      return 500;
    case PrintfLevel.info:
    case PrintfLevel.success:
      return 800;
    case PrintfLevel.warning:
      return 900;
    case PrintfLevel.error:
      return 1000;
  }
}
