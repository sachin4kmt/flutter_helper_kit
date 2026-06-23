

/// ---------------------------
/// Double Extensions
/// ---------------------------
extension DoubleSmartRoundExtension on double {
  /// Converts to a rounded string, trimming unnecessary trailing zeros.
  String toStringAsSmartRounded({int maxPrecision = 2}) {
    return _toSmartString(this, maxPrecision);
  }

  /// Converts to num after smart rounding
  num toNumAsSmartRound({int maxPrecision = 2}) {
    final rounded = toStringAsSmartRounded(maxPrecision: maxPrecision);
    return rounded.contains('.') ? double.parse(rounded) : int.parse(rounded);
  }
}

/// ---------------------------
/// Double? Extensions
/// ---------------------------
extension DoubleNullSmartRoundExtension on double? {

  /// Converts to a rounded string, trimming unnecessary trailing zeros.
  /// Defaults to "0" if null.
  String? toStringAsSmartRounded({int maxPrecision = 2}) {
    if(this==null)return null;
    return _toSmartString(this!, maxPrecision);
  }

  num? toNumAsSmartRound({int maxPrecision = 2}) {
    if(this==null)return null;
    return  this!.toNumAsSmartRound(maxPrecision: maxPrecision);
  }
}

/// ---------------------------
/// Num Extensions
/// ---------------------------
extension NumSmartRoundExtension on num {


  /// Converts to a rounded string, trimming unnecessary trailing zeros.
  String toStringAsSmartRounded({int maxPrecision = 2}) {
    return _toSmartString(toDouble(), maxPrecision);
  }

  num toNumAsSmartRound({int maxPrecision = 2}) {
    return toDouble().toNumAsSmartRound(maxPrecision: maxPrecision);
  }
}

/// ---------------------------
/// Num? Extensions
/// ---------------------------
extension NumNullSmartRoundExtension on num? {

  String? toStringAsSmartRounded({int maxPrecision = 2}) {
    if(this==null)return null;
    return _toSmartString(this!.toDouble(), maxPrecision);
  }

  num? toNumAsSmartRound({int maxPrecision = 2}) {
    if (this == null) return null;
    return this!.toDouble().toNumAsSmartRound(maxPrecision: maxPrecision);
  }
}

/// ---------------------------
/// Private Helper
/// ---------------------------
String _toSmartString(double value, int maxPrecision) {
  final str = value.toString();
  try {
    if (str.contains('.')) {
      final split = str.split('');
      final mantissa = <String>[];
      final periodIndex = str.indexOf('.');
      final wholePart = str.substring(0, periodIndex);
      int numChars = 0;
      for (var i = periodIndex + 1; i < str.length; i++) {
        if (numChars >= maxPrecision) break;
        mantissa.add(split[i]);
        numChars++;
      }
      if (mantissa.isNotEmpty) {
        int i = mantissa.length - 1;
        while (mantissa.isNotEmpty && mantissa[i] == '0') {
          mantissa.removeLast();
          i--;
        }
        if (mantissa.isNotEmpty) {
          return '$wholePart.${mantissa.join()}';
        }
      }
      return wholePart;
    }
  } catch (_) {}
  return str;
}