extension MapExtensions on dynamic {
  /// Converts the value to a [num] if possible.
  ///
  /// Returns the value as [num] if it's already a [num],
  /// or attempts to parse it if it's a [String].
  /// Returns `null` if conversion is not possible.
  num? toNum() {
    if (this is num) {
      return this as num;
    } else if (this is String) {
      return num.tryParse(this as String);
    }
    return null;
  }

  /// Converts the value to a [double].
  ///
  /// - Returns `0.0` if the value is `null`.
  /// - Returns the value if it's already a [double].
  /// - Converts and returns the value if it's an [int] or a [String].
  /// - Throws a [FormatException] if conversion is not possible.
  double toDouble() {
    if (this == null) {
      return 0.0;
    } else if (this is double) {
      return this as double;
    } else if (this is int) {
      return (this as int).toDouble();
    } else if (this is String) {
      return double.tryParse(this as String) ?? 0.0;
    } else {
      throw FormatException('Cannot convert $this to double');
    }
  }

  /// Converts the value to an [int].
  ///
  /// - Returns `0` if the value is `null`.
  /// - Returns the value if it's already an [int].
  /// - Converts and returns the value if it's a [double] or a [String].
  /// - Throws a [FormatException] if conversion is not possible.
  int toInt() {
    if (this == null) {
      return 0;
    } else if (this is int) {
      return this as int;
    } else if (this is double) {
      return (this as double).toInt();
    } else if (this is String) {
      return int.tryParse(this as String) ?? 0;
    } else {
      throw FormatException('Cannot convert $this to int');
    }
  }
}
