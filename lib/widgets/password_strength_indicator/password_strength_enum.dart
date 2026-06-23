
import 'package:flutter/material.dart';

enum PasswordStrength {
  none,
  weak,
  fair,
  good,
  strong,
  veryStrong;
}

extension PasswordStrengthLable on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.none:
        return '';
        case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.fair:
        return 'Fair';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
      case PasswordStrength.veryStrong:
        return 'Very Strong';
    }
  }
}



extension PasswordStrengthColor on PasswordStrength {
  Color get color {
    switch (this) {
      case PasswordStrength.none:
        return Colors.blue;
        case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.fair:
        return Colors.orange;
      case PasswordStrength.good:
        return Colors.amber;
      case PasswordStrength.strong:
        return Colors.blue;
      case PasswordStrength.veryStrong:
        return Colors.green;
    }
  }
}