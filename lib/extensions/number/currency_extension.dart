import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/number/smart_round_to_string.dart';

/// Number grouping style for [NumCurrencyExtension.toCurrency].
enum CurrencyStyle {
  /// Indian numbering: `10,00,000` / `1,00,00,000`.
  indian,

  /// International numbering: `1,000,000` / `10,000,000`.
  international,
}

/// Where the currency [symbol] is placed relative to the amount.
enum CurrencySymbolPosition {
  /// `$1,000.00`
  leading,

  /// `1,000.00$`
  trailing,
}

/// Formats numbers as currency strings (no localization dependency).
extension NumCurrencyExtension on num {
  /// Formats this number as currency.
  ///
  /// Defaults to Indian grouping and `₹`. Uses [toNumAsSmartRound] when
  /// [smartDecimal] is `true`.
  ///
  /// ```dart
  /// 1234567.89.toCurrency();
  /// // ₹12,34,567.89
  ///
  /// 1000000.toCurrency(
  ///   style: CurrencyStyle.international,
  ///   symbol: r'$',
  /// );
  /// // $1,000,000
  /// ```
  String toCurrency({
    CurrencyStyle style = CurrencyStyle.indian,
    String symbol = '₹',
    CurrencySymbolPosition symbolPosition = CurrencySymbolPosition.leading,
    int decimalDigits = 2,
    bool smartDecimal = true,
    bool showSymbol = true,
  }) {
    final parts = _formatCurrency(
      this,
      style: style,
      symbol: symbol,
      symbolPosition: symbolPosition,
      decimalDigits: decimalDigits,
      smartDecimal: smartDecimal,
      showSymbol: showSymbol,
    );
    return parts.toString();
  }

  /// Formats this number as a styled [Text] widget.
  ///
  /// Style rules:
  /// * Only [textStyle] → applied to **amount and symbol**
  /// * Only [symbolTextStyle] → applied to **amount and symbol**
  /// * Both set → [textStyle] on amount, [symbolTextStyle] on symbol
  ///
  /// ```dart
  /// 1000.toCurrencyText(
  ///   textStyle: TextStyle(fontSize: 16),
  ///   symbolTextStyle: TextStyle(fontSize: 12, color: Colors.grey),
  /// );
  /// ```
  Text toCurrencyText({
    Key? key,
    CurrencyStyle style = CurrencyStyle.indian,
    String symbol = '₹',
    CurrencySymbolPosition symbolPosition = CurrencySymbolPosition.leading,
    int decimalDigits = 2,
    bool smartDecimal = true,
    bool showSymbol = true,
    TextStyle? textStyle,
    TextStyle? symbolTextStyle,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    StrutStyle? strutStyle,
  }) {
    return _currencyText(
      this,
      key: key,
      style: style,
      symbol: symbol,
      symbolPosition: symbolPosition,
      decimalDigits: decimalDigits,
      smartDecimal: smartDecimal,
      showSymbol: showSymbol,
      textStyle: textStyle,
      symbolTextStyle: symbolTextStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      strutStyle: strutStyle,
    );
  }
}

/// Nullable currency formatting.
extension NumNullCurrencyExtension on num? {
  /// Formats this number as currency.
  ///
  /// * When `null` and [nullValue] is set → returns [nullValue].
  /// * When `null` and [nullValue] is omitted → formats **0**.
  String toCurrency({
    CurrencyStyle style = CurrencyStyle.indian,
    String symbol = '₹',
    CurrencySymbolPosition symbolPosition = CurrencySymbolPosition.leading,
    int decimalDigits = 2,
    bool smartDecimal = true,
    bool showSymbol = true,
    String? nullValue,
  }) {
    if (this == null) {
      if (nullValue != null) return nullValue;
      return 0.toCurrency(
        style: style,
        symbol: symbol,
        symbolPosition: symbolPosition,
        decimalDigits: decimalDigits,
        smartDecimal: smartDecimal,
        showSymbol: showSymbol,
      );
    }
    return this!.toCurrency(
      style: style,
      symbol: symbol,
      symbolPosition: symbolPosition,
      decimalDigits: decimalDigits,
      smartDecimal: smartDecimal,
      showSymbol: showSymbol,
    );
  }

  /// Formats this number as a styled [Text] widget.
  ///
  /// See [NumCurrencyExtension.toCurrencyText] for style rules.
  ///
  /// When `null` and [nullValue] is set, returns a [Text] with [nullValue]
  /// using the resolved amount style (`textStyle ?? symbolTextStyle`).
  Text toCurrencyText({
    Key? key,
    CurrencyStyle style = CurrencyStyle.indian,
    String symbol = '₹',
    CurrencySymbolPosition symbolPosition = CurrencySymbolPosition.leading,
    int decimalDigits = 2,
    bool smartDecimal = true,
    bool showSymbol = true,
    TextStyle? textStyle,
    TextStyle? symbolTextStyle,
    String? nullValue,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    StrutStyle? strutStyle,
  }) {
    if (this == null && nullValue != null) {
      return Text(
        nullValue,
        key: key,
        style: textStyle ?? symbolTextStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        strutStyle: strutStyle,
      );
    }
    return (this ?? 0).toCurrencyText(
      key: key,
      style: style,
      symbol: symbol,
      symbolPosition: symbolPosition,
      decimalDigits: decimalDigits,
      smartDecimal: smartDecimal,
      showSymbol: showSymbol,
      textStyle: textStyle,
      symbolTextStyle: symbolTextStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      strutStyle: strutStyle,
    );
  }
}

Text _currencyText(
  num value, {
  Key? key,
  required CurrencyStyle style,
  required String symbol,
  required CurrencySymbolPosition symbolPosition,
  required int decimalDigits,
  required bool smartDecimal,
  required bool showSymbol,
  TextStyle? textStyle,
  TextStyle? symbolTextStyle,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
  StrutStyle? strutStyle,
}) {
  // One style provided → apply to both; both provided → apply separately.
  final TextStyle? amountStyle = textStyle ?? symbolTextStyle;
  final TextStyle? resolvedSymbolStyle = symbolTextStyle ?? textStyle;

  final parts = _formatCurrency(
    value,
    style: style,
    symbol: symbol,
    symbolPosition: symbolPosition,
    decimalDigits: decimalDigits,
    smartDecimal: smartDecimal,
    showSymbol: showSymbol,
  );

  if (!parts.hasSymbol) {
    return Text(
      parts.amount,
      key: key,
      style: amountStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      strutStyle: strutStyle,
    );
  }

  final TextSpan symbolSpan = TextSpan(
    text: parts.symbol,
    style: resolvedSymbolStyle,
  );
  final TextSpan amountSpan = TextSpan(
    text: parts.amount,
    style: amountStyle,
  );

  return Text.rich(
    TextSpan(
      children: parts.symbolPosition == CurrencySymbolPosition.leading
          ? <InlineSpan>[symbolSpan, amountSpan]
          : <InlineSpan>[amountSpan, symbolSpan],
    ),
    key: key,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    strutStyle: strutStyle,
  );
}

class _CurrencyParts {
  const _CurrencyParts({
    required this.amount,
    required this.symbol,
    required this.hasSymbol,
    required this.symbolPosition,
  });

  final String amount;
  final String symbol;
  final bool hasSymbol;
  final CurrencySymbolPosition symbolPosition;

  @override
  String toString() {
    if (!hasSymbol) return amount;
    return symbolPosition == CurrencySymbolPosition.leading
        ? '$symbol$amount'
        : '$amount$symbol';
  }
}

_CurrencyParts _formatCurrency(
  num value, {
  required CurrencyStyle style,
  required String symbol,
  required CurrencySymbolPosition symbolPosition,
  required int decimalDigits,
  required bool smartDecimal,
  required bool showSymbol,
}) {
  assert(decimalDigits >= 0);

  final num prepared = smartDecimal
      ? value.toNumAsSmartRound(maxPrecision: decimalDigits)
      : _fixedRound(value, decimalDigits);

  final bool isNegative = prepared < 0;
  final num absolute = prepared.abs();

  final String raw = smartDecimal
      ? absolute.toStringAsSmartRounded(maxPrecision: decimalDigits)
      : absolute.toStringAsFixed(decimalDigits);

  final parts = raw.split('.');
  final String groupedInt = _groupInteger(parts[0], style);
  final String decimalPart = parts.length > 1 ? parts[1] : '';

  final String amount =
      decimalPart.isEmpty ? groupedInt : '$groupedInt.$decimalPart';
  final String signed = isNegative ? '-$amount' : amount;

  final bool withSymbol = showSymbol && symbol.isNotEmpty;
  return _CurrencyParts(
    amount: signed,
    symbol: withSymbol ? symbol : '',
    hasSymbol: withSymbol,
    symbolPosition: symbolPosition,
  );
}

num _fixedRound(num value, int decimalDigits) {
  if (decimalDigits == 0) return value.round();
  final factor = _pow10(decimalDigits);
  return (value * factor).round() / factor;
}

int _pow10(int exp) {
  var result = 1;
  for (var i = 0; i < exp; i++) {
    result *= 10;
  }
  return result;
}

String _groupInteger(String digits, CurrencyStyle style) {
  if (digits.length <= 3) return digits;

  switch (style) {
    case CurrencyStyle.international:
      return _groupInternational(digits);
    case CurrencyStyle.indian:
      return _groupIndian(digits);
  }
}

/// Groups every 3 digits from the right: `1000000` → `1,000,000`.
String _groupInternational(String digits) {
  final buffer = StringBuffer();
  final len = digits.length;
  for (var i = 0; i < len; i++) {
    if (i > 0 && (len - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// Indian grouping: last 3 digits, then every 2: `1000000` → `10,00,000`.
String _groupIndian(String digits) {
  if (digits.length <= 3) return digits;

  final last3 = digits.substring(digits.length - 3);
  var rest = digits.substring(0, digits.length - 3);
  final parts = <String>[];

  while (rest.length > 2) {
    parts.insert(0, rest.substring(rest.length - 2));
    rest = rest.substring(0, rest.length - 2);
  }
  if (rest.isNotEmpty) parts.insert(0, rest);

  return '${parts.join(',')},$last3';
}
