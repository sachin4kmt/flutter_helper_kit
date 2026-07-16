import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An advanced [TextInputFormatter] for numeric fields.
///
/// Features:
/// * **Decimal support with precision control** via [decimalRange]
///   (`null` = unlimited, `0` = integers only, `n` = up to `n` fraction digits).
/// * **Negative number support** via [allowNegative].
/// * **Range validation** via [min] / [max] with live feedback.
/// * **Live error feedback** through [errorNotifier].
/// * **State management integration** through [valueNotifier] (parsed [num]).
///
/// Character-level rules (precision, sign, single decimal point) are enforced
/// hard — invalid keystrokes are rejected. Range rules are enforced soft — the
/// value is still accepted while typing, but [errorNotifier] is updated so the
/// UI can show an inline error.
///
/// ```dart
/// final errorText = ValueNotifier<String?>(null);
/// final value = ValueNotifier<num?>(null);
///
/// TextField(
///   keyboardType: const TextInputType.numberWithOptions(
///     decimal: true,
///     signed: true,
///   ),
///   inputFormatters: [
///     DecimalTextInputFormatter(
///       decimalRange: 2,
///       allowNegative: true,
///       min: -50,
///       max: 100,
///       errorNotifier: errorText,
///       valueNotifier: value,
///     ),
///   ],
/// );
///
/// // Show live error:
/// ValueListenableBuilder<String?>(
///   valueListenable: errorText,
///   builder: (_, error, __) => Text(error ?? ''),
/// );
/// ```
class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({
    this.decimalRange = 2,
    this.allowNegative = false,
    this.min,
    this.max,
    this.errorNotifier,
    this.valueNotifier,
    this.minErrorText,
    this.maxErrorText,
  })  : assert(
          decimalRange == null || decimalRange >= 0,
          'decimalRange must be null or >= 0',
        ),
        assert(
          min == null || max == null || min <= max,
          'min must be less than or equal to max',
        );

  /// Number of digits allowed after the decimal point.
  ///
  /// * `null` — unlimited fraction digits.
  /// * `0` — integers only (decimal point not allowed).
  /// * `n` — at most `n` fraction digits.
  final int? decimalRange;

  /// Whether a leading minus sign is allowed.
  final bool allowNegative;

  /// Inclusive minimum. When the parsed value is below this, [errorNotifier]
  /// is updated with [minErrorText].
  final num? min;

  /// Inclusive maximum. When the parsed value is above this, [errorNotifier]
  /// is updated with [maxErrorText].
  final num? max;

  /// Receives the current validation error message (or `null` when valid).
  final ValueNotifier<String?>? errorNotifier;

  /// Receives the current parsed value (or `null` when empty/incomplete).
  final ValueNotifier<num?>? valueNotifier;

  /// Custom message when the value is below [min].
  final String? minErrorText;

  /// Custom message when the value is above [max].
  final String? maxErrorText;

  RegExp get _allowedPattern {
    final sign = allowNegative ? '-?' : '';
    if (decimalRange == null) {
      return RegExp('^$sign\\d*\\.?\\d*\$');
    }
    if (decimalRange == 0) {
      return RegExp('^$sign\\d*\$');
    }
    return RegExp('^$sign\\d*\\.?\\d{0,$decimalRange}\$');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) {
      _publish(null, null);
      return newValue;
    }

    if (!_allowedPattern.hasMatch(text)) {
      return oldValue;
    }

    if (text.contains('-') && !text.startsWith('-')) {
      return oldValue;
    }
    if ('-'.allMatches(text).length > 1) {
      return oldValue;
    }
    if ('.'.allMatches(text).length > 1) {
      return oldValue;
    }

    // Partial/in-progress values like "-", ".", "-." are structurally valid
    // while typing, but cannot be range-validated yet.
    final parsed = num.tryParse(text);
    if (parsed == null) {
      _publish(null, null);
      return newValue;
    }

    _publish(parsed, _rangeError(parsed));
    return newValue;
  }

  String? _rangeError(num value) {
    if (min != null && value < min!) {
      return minErrorText ?? 'Value must be at least $min';
    }
    if (max != null && value > max!) {
      return maxErrorText ?? 'Value must be at most $max';
    }
    return null;
  }

  void _publish(num? value, String? error) {
    final valueListenable = valueNotifier;
    final errorListenable = errorNotifier;
    if (valueListenable != null && valueListenable.value != value) {
      valueListenable.value = value;
    }
    if (errorListenable != null && errorListenable.value != error) {
      errorListenable.value = error;
    }
  }
}
