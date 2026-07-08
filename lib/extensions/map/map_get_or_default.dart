part of 'map_extension.dart';

/// Typed getters for [Map] values — simple defaults and API/JSON parsing.
extension MapGetOrDefault<K, V> on Map<K, V> {
  /// Returns the value associated with the given `key`,
  /// or `defaultValue` if the key does not exist.
  V? getOrDefault(K key, V? defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;

  /// Returns the integer value for [key], or [defaultValue] when missing/invalid.
  int? getIntOrDefault(K key, int? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    return _parseInt(this[key], defaultValue);
  }

  /// Returns the numeric value for [key], or [defaultValue] when missing/invalid.
  num? getNumOrDefault(K key, num? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    return _parseNum(this[key], defaultValue);
  }

  /// Returns the double value for [key], or [defaultValue] when missing/invalid.
  double? getDoubleOrDefault(K key, double? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    return _parseDouble(this[key], defaultValue);
  }

  /// Returns the string value for [key], or [defaultValue] when missing.
  String? getStringOrDefault(K key, String? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    return _parseString(this[key], defaultValue);
  }

  /// Returns a trimmed string for [key] or the first matching [alternativeKeys].
  String? getApiStringOrDefault(
    K key, {
    String? defaultValue,
    List<K> alternativeKeys = const [],
  }) {
    return _parseString(_valueFor(key, alternativeKeys), defaultValue);
  }

  /// Returns a validated URL string or [defaultValue] when invalid.
  String? getApiUrlStringOrDefault(
    K key, {
    String? defaultValue,
    List<K> alternativeKeys = const [],
  }) {
    final value = _valueFor(key, alternativeKeys);
    if (value == null) return defaultValue;

    try {
      final urlStr = value.toString().trim();
      if (urlStr.isEmpty || urlStr.toLowerCase() == 'null') {
        return defaultValue;
      }

      final uri = Uri.tryParse(urlStr);
      if (uri == null || (!uri.hasScheme && !uri.hasAuthority)) {
        return defaultValue;
      }

      return urlStr;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error parsing URL for key "$key": $e');
      }
      return defaultValue;
    }
  }

  int? getApiIntOrDefault(
    K key, [
    int? defaultValue,
    List<K> alternativeKeys = const [],
  ]) {
    return _parseInt(_valueFor(key, alternativeKeys), defaultValue);
  }

  num? getApiNumOrDefault(
    K key, {
    num? defaultValue,
    List<K> alternativeKeys = const [],
    bool smartRound = true,
    int maxPrecision = 2,
  }) {
    final parsed = _parseNum(_valueFor(key, alternativeKeys), defaultValue);
    if (!smartRound || parsed == null) return parsed;
    return parsed.toNumAsSmartRound(maxPrecision: maxPrecision);
  }

  double? getApiDoubleOrDefault(
    K key, {
    double? defaultValue,
    List<K> alternativeKeys = const [],
    bool smartRound = false,
    int maxPrecision = 2,
  }) {
    final parsed = _parseDouble(_valueFor(key, alternativeKeys), defaultValue);
    if (parsed == null) return defaultValue;
    if (!smartRound) return parsed;
    return parsed.toNumAsSmartRound(maxPrecision: maxPrecision).toDouble();
  }

  bool getApiBoolOrDefault(
    K key, {
    bool defaultValue = false,
    List<K> alternativeKeys = const [],
  }) {
    return _parseBool(_valueFor(key, alternativeKeys), defaultValue);
  }

  List<T> getApiListOrDefault<T>(
    K key, {
    List<T> defaultValue = const [],
    List<K> alternativeKeys = const [],
  }) {
    return _parseList<T>(_valueFor(key, alternativeKeys), defaultValue);
  }

  DateTime? getApiDateTimeOrDefault(
    K key, {
    DateTime? defaultValue,
    List<K> alternativeKeys = const [],
    bool isUtc = true,
    bool trySecondsEpoch = true,
  }) {
    return _parseDateTime(
      _valueFor(key, alternativeKeys),
      defaultValue,
      isUtc,
      trySecondsEpoch,
    );
  }

  TimeOfDay? getApiTimeOfDayOrDefault(
    K key, {
    TimeOfDay? defaultValue,
    List<K> alternativeKeys = const [],
  }) {
    return _parseTimeOfDay(_valueFor(key, alternativeKeys), defaultValue);
  }

  Map<String, dynamic>? getApiMapObject(
    K key, {
    List<K> alternativeKeys = const [],
  }) {
    return _parseToMap(_valueFor(key, alternativeKeys));
  }

  T? getApiObjectOrDefault<T>(
    K key, {
    T? defaultValue,
    List<K> alternativeKeys = const [],
  }) {
    try {
      final value = _valueFor(key, alternativeKeys);
      if (value is T) return value;
      return defaultValue;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error parsing object for key "$key": $e');
      }
      return defaultValue;
    }
  }

  Color? getApiColorOrDefault(
    K key, {
    Color? defaultValue,
    List<K> alternativeKeys = const [],
  }) {
    return _parseColor(_valueFor(key, alternativeKeys), defaultValue);
  }

  /// Returns a copy of this map without [keysToExclude].
  Map<K, V> excludeKeys(List<K> keysToExclude) {
    if (isEmpty || keysToExclude.isEmpty) return Map<K, V>.from(this);
    return {
      for (final entry in entries)
        if (!keysToExclude.contains(entry.key)) entry.key: entry.value,
    };
  }

  /// Returns a new map with [key] added or replaced.
  Map<K, V> addKeyValue(K key, V value) => {...this, key: value};

  /// Merges [additionalKeys] and optionally removes [excludeKeys].
  Map<K, V> addKeyWithExcludeKeys(
    Map<K, V> additionalKeys, {
    List<K> excludeKeys = const [],
  }) {
    return {
      ...this,
      ...Map<K, V>.from(additionalKeys)
        ..removeWhere((key, _) => excludeKeys.contains(key)),
    };
  }

  T? _tryGet<T>(K key) => containsKey(key) ? this[key] as T? : null;

  V? _tryFirstMatch(List<K> keys) {
    for (final key in keys) {
      if (containsKey(key)) return this[key];
    }
    return null;
  }

  dynamic _valueFor(K key, List<K> alternativeKeys) =>
      _tryGet(key) ?? _tryFirstMatch(alternativeKeys);

  String? _parseString(dynamic value, [String? defaultValue]) {
    try {
      if (value == null) return defaultValue;
      final str = value.toString().trim();
      return (str.isEmpty || str.toLowerCase() == 'null') ? defaultValue : str;
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing string: $e');
      return defaultValue;
    }
  }

  int? _parseInt(dynamic value, [int? defaultValue]) {
    try {
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value) ?? defaultValue;
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing int: $e');
    }
    return defaultValue;
  }

  num? _parseNum(dynamic value, [num? defaultValue]) {
    try {
      if (value is num) return value;
      if (value is String) return num.tryParse(value) ?? defaultValue;
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing num: $e');
    }
    return defaultValue;
  }

  double? _parseDouble(dynamic value, [double? defaultValue]) {
    try {
      if (value is double) return value;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? defaultValue;
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing double: $e');
    }
    return defaultValue;
  }

  bool _parseBool(dynamic value, [bool defaultValue = false]) {
    try {
      if (value == null) return defaultValue;
      if (value is bool) return value;
      if (value is num) return value != 0;
      if (value is String) {
        final lower = value.trim().toLowerCase();
        if (['true', '1', 'yes', 'y', 'on', 'active', 'enable']
            .contains(lower)) {
          return true;
        }
        if (['false', '0', 'no', 'n', 'off', 'inactive', 'disable']
            .contains(lower)) {
          return false;
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing bool: $e');
    }
    return defaultValue;
  }

  DateTime? _parseDateTime(
    dynamic value,
    DateTime? defaultValue,
    bool isUtc,
    bool trySecondsEpoch,
  ) {
    try {
      if (value == null) return defaultValue;
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value) ?? defaultValue;
      if (value is num) {
        final millis =
            trySecondsEpoch && value < 10000000000 ? value * 1000 : value;
        return DateTime.fromMillisecondsSinceEpoch(
          millis.toInt(),
          isUtc: isUtc,
        );
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing DateTime: $e');
    }
    return defaultValue;
  }

  TimeOfDay? _parseTimeOfDay(dynamic value, [TimeOfDay? defaultValue]) {
    try {
      if (value == null) return defaultValue;
      if (value is TimeOfDay) return value;

      if (value is String) {
        final str = value.trim();
        if (str.isEmpty || str.toLowerCase() == 'null') return defaultValue;

        final dateTime = DateTime.tryParse(str);
        if (dateTime != null) {
          return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
        }

        final parts = str.split(':');
        if (parts.length >= 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour != null && minute != null) {
            return TimeOfDay(hour: hour, minute: minute);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing TimeOfDay: $e');
    }
    return defaultValue;
  }

  List<T> _parseList<T>(dynamic value, List<T> defaultValue) {
    try {
      if (value is List<T>) return value;
      if (value is List) return value.whereType<T>().toList();
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing list: $e');
    }
    return defaultValue;
  }

  Map<String, dynamic>? _parseToMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) {
          return decoded.map((key, val) => MapEntry(key.toString(), val));
        }
      } catch (e) {
        if (kDebugMode) debugPrint('JSON decode failed: $e');
      }
    }
    return null;
  }

  Color? _parseColor(dynamic value, Color? defaultValue) {
    try {
      if (value == null) return defaultValue;
      if (value is Color) return value;
      if (value is int) return Color(value);

      if (value is String) {
        var hex = value.trim().toUpperCase().replaceAll('#', '');
        if (hex.isEmpty || hex == 'NULL') return defaultValue;
        if (hex.length == 6) hex = 'FF$hex';
        if (hex.length == 8) return Color(int.parse(hex, radix: 16));
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Error parsing Color: $e');
    }
    return defaultValue;
  }
}
