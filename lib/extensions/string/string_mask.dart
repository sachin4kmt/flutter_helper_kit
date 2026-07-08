/// String masking extensions for phone numbers, emails, and generic values.
extension StringMaskExtension on String? {
  bool get _isEmptyOrNull =>
      this == null ||
      (this != null && this!.isEmpty) ||
      (this != null && this! == 'null');

  /// Masks the middle of a string, revealing [visibleStart] characters from the
  /// start and [visibleEnd] characters from the end.
  ///
  /// Example:
  /// ```dart
  /// '9876543210'.mask(visibleStart: 2, visibleEnd: 4); // 98******3210
  /// '9876543210'.mask(visibleStart: 0, visibleEnd: 4); // ********3210
  /// ```
  String mask({
    int visibleStart = 2,
    int visibleEnd = 2,
    String maskChar = '*',
    bool maskIfShorter = false,
  }) {
    if (_isEmptyOrNull) return '';

    final value = this!.trim();
    final length = value.length;

    if (length <= visibleStart + visibleEnd) {
      return maskIfShorter ? _repeatMask(maskChar, length) : value;
    }

    final start = value.substring(0, visibleStart);
    final end = visibleEnd > 0 ? value.substring(length - visibleEnd) : '';
    final hiddenCount = length - visibleStart - visibleEnd;

    return '$start${_repeatMask(maskChar, hiddenCount)}$end';
  }

  /// Masks a phone number after stripping non-digit characters.
  ///
  /// Use [visibleStart] and [visibleEnd] to control how many digits remain
  /// visible at the beginning and end. When [keepPlusPrefix] is `true` and the
  /// input starts with `+`, the plus sign is preserved in the output.
  ///
  /// Example:
  /// ```dart
  /// '9876543210'.maskPhone(visibleStart: 2, visibleEnd: 4); // 98******3210
  /// '+919876543210'.maskPhone(visibleStart: 3, visibleEnd: 4); // +919*****3210
  /// ```
  String maskPhone({
    int visibleStart = 2,
    int visibleEnd = 4,
    String maskChar = '*',
    bool keepPlusPrefix = true,
    bool maskIfShorter = false,
    String? separator,
  }) {
    if (_isEmptyOrNull) return '';

    final raw = this!.trim();
    final hasPlus = keepPlusPrefix && raw.startsWith('+');
    final digits = raw.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) return '';

    final maskedDigits = digits.mask(
      visibleStart: visibleStart,
      visibleEnd: visibleEnd,
      maskChar: maskChar,
      maskIfShorter: maskIfShorter,
    );

    final result = hasPlus ? '+$maskedDigits' : maskedDigits;

    if (separator == null || separator.isEmpty) return result;

    return _formatWithSeparator(
      value: result,
      separator: separator,
      preservePrefix: hasPlus ? '+' : null,
      groupSize: 2,
    );
  }

  /// Masks the local part of an email address before `@`.
  ///
  /// Use [visibleStart] and [visibleEnd] to control the visible characters in
  /// the local part. Set [maskDomain] to `true` to also mask the domain using
  /// [domainVisibleStart] and [domainVisibleEnd].
  ///
  /// Example:
  /// ```dart
  /// 'user@example.com'.maskEmail(visibleStart: 1, visibleEnd: 0); // u***@example.com
  /// 'john.doe@gmail.com'.maskEmail(visibleStart: 2, visibleEnd: 2); // jo****oe@gmail.com
  /// ```
  String maskEmail({
    int visibleStart = 1,
    int visibleEnd = 0,
    String maskChar = '*',
    bool maskDomain = false,
    int domainVisibleStart = 0,
    int domainVisibleEnd = 0,
    bool maskIfShorter = false,
  }) {
    if (_isEmptyOrNull) return '';

    final email = this!.trim();
    final atIndex = email.indexOf('@');

    if (atIndex <= 0 || atIndex >= email.length - 1) {
      return email.mask(
        visibleStart: visibleStart,
        visibleEnd: visibleEnd,
        maskChar: maskChar,
        maskIfShorter: maskIfShorter,
      );
    }

    final local = email.substring(0, atIndex);
    final domain = email.substring(atIndex + 1);

    final maskedLocal = local.mask(
      visibleStart: visibleStart,
      visibleEnd: visibleEnd,
      maskChar: maskChar,
      maskIfShorter: maskIfShorter,
    );

    final maskedDomain = maskDomain
        ? domain.mask(
            visibleStart: domainVisibleStart,
            visibleEnd: domainVisibleEnd,
            maskChar: maskChar,
            maskIfShorter: maskIfShorter,
          )
        : domain;

    return '$maskedLocal@$maskedDomain';
  }

  String _repeatMask(String maskChar, int count) {
    if (count <= 0) return '';
    if (maskChar.length == 1) return maskChar * count;
    return List.filled(count, maskChar).join();
  }

  String _formatWithSeparator({
    required String value,
    required String separator,
    required int groupSize,
    String? preservePrefix,
  }) {
    var workingValue = value;
    var prefix = '';

    if (preservePrefix != null && workingValue.startsWith(preservePrefix)) {
      prefix = preservePrefix;
      workingValue = workingValue.substring(preservePrefix.length);
    }

    final buffer = StringBuffer(prefix);
    for (var i = 0; i < workingValue.length; i++) {
      if (i > 0 && i % groupSize == 0) {
        buffer.write(separator);
      }
      buffer.write(workingValue[i]);
    }

    return buffer.toString();
  }
}
