import 'package:flutter/services.dart';

/// A lightweight [TextInputFormatter] that keeps numeric input non-zero.
///
/// It rejects a lone `0` and any redundant leading zero (`00`, `01`, `007`),
/// so the entered number can never be zero or zero-prefixed. An optional
/// leading minus sign is tolerated (the check runs on the digits after it).
///
/// By default [allowDecimalZero] permits `0.` / `0.5` style values while typing,
/// since those are non-zero decimals. Set it to `false` to reject every value
/// that starts with `0`.
///
/// ```dart
/// TextField(
///   keyboardType: TextInputType.number,
///   inputFormatters: [
///     FilteringTextInputFormatter.digitsOnly,
///     NonZeroFormatter(),
///   ],
/// );
/// ```
class NonZeroFormatter extends TextInputFormatter {
  NonZeroFormatter({this.allowDecimalZero = true});

  /// When `true`, a leading `0` is allowed only when it is the start of a
  /// decimal (`0.` or `0.5`). When `false`, any leading `0` is rejected.
  final bool allowDecimalZero;

  static final RegExp _zeroDecimal = RegExp(r'^0\.\d*$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    var body = text;
    if (body.startsWith('-')) {
      body = body.substring(1);
    }

    // Only a sign so far — nothing to validate yet.
    if (body.isEmpty) return newValue;

    if (body.startsWith('0')) {
      if (!allowDecimalZero) return oldValue;
      final isZeroDecimal = body == '0' || _zeroDecimal.hasMatch(body);
      if (!isZeroDecimal) return oldValue;
    }

    return newValue;
  }
}
