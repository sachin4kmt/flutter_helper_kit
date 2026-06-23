

extension ConversionExtension on Object? {
  /// Convert to num (int or double) safely
  num? toNum({num? defaultValue}) {
    if (this == null) return defaultValue;
    if (this is num) return this as num;
    if (this is String) return num.tryParse(this as String) ?? defaultValue;
    if (this is bool) return (this as bool) ? 1 : 0;

    return defaultValue;
  }

  /// Convert to int safely
  int? toInt({int? defaultValue}) {
    if (this == null) return defaultValue;
    if (this is int) return this as int;
    if (this is double) return (this as double).toInt();
    if (this is String) return int.tryParse(this as String) ?? defaultValue;
    if (this is bool) return (this as bool) ? 1 : 0;
    return defaultValue;
  }

  /// Convert to double safely
  double? toDouble({double? defaultValue}) {
    if (this == null) return defaultValue;
    if (this is double) return this as double;
    if (this is String) return double.tryParse(this as String) ?? defaultValue;
    if (this is int) return (this as int).toDouble();
    if (this is bool) return (this as bool) ? 1 : 0;
    return defaultValue;
  }

  /// Convert to String safely

  String? toStr({String? defaultValue}) {
    if(this == null) return defaultValue;
    return this?.toString().trim() ?? defaultValue;
  }

  /// Convert to bool safely
  bool? toBool({bool? defaultValue}) {
    if (this == null) return defaultValue;
    if (this is bool) return this as bool;
    if (this is String) {
      final lowerValue = (this as String).trim().toLowerCase();
      if (['true', 'yes', '1', 'on'].contains(lowerValue)) return true;
      if (['false', 'no', '0', 'off'].contains(lowerValue)) return false;
    }
    if (this is num) return (this as num) != 0;
    return defaultValue;
  }
}
