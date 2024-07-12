import 'package:flutter/services.dart';

/// A text input formatter that prevents users from starting the text with a space.
///
/// This formatter removes any leading spaces from the text input and ensures
/// that users cannot start typing with a space.
///
class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      final String trimText = newValue.text.trimLeft();
      return TextEditingValue(
        text: trimText,
        selection: TextSelection(
          baseOffset: trimText.length,
          extentOffset: trimText.length,
        ),
      );
    }
    // Return the new value as it is if it doesn't start with a space
    return newValue;
  }
}
