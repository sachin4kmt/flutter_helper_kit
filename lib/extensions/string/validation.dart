import 'package:flutter_helper_kit/flutter_helper_kit.dart';

extension EmailValidation on String {
  /// Checks whether the given string is a valid email address.
  ///
  /// This method trims the input, converts it to lowercase, and then matches it
  /// against a standard email regex pattern.
  ///
  /// Returns `true` if the string is a valid email, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// String email = "user@example.com";
  /// bool isValid = email.isValidateEmail(); // true
  ///
  /// String invalidEmail = "user@@example..com";
  /// bool isInvalid = invalidEmail.isValidateEmail(); // false
  /// ```
  bool isValidateEmail() {
    if (isEmptyOrNull) return false;
    return hasMatch(this.toLowerCase().trim(), RegExpPatterns.email);
  }

  /// Validates whether the given string is a properly formatted email address
  /// using an **enhanced regular expression**.
  ///
  /// This method checks the string against `RegExpPatterns.emailEnhanced`,
  /// a more comprehensive email validation pattern compared to the standard regex.
  ///
  /// ### Key Features:
  /// - Supports **standard email formats** (e.g., `user@example.com`).
  /// - Allows **plus addressing** (e.g., `user+alias@example.com`).
  /// - Supports **subdomains** (e.g., `user@mail.example.co.uk`).
  /// - Validates **domain literals** (e.g., `user@[192.168.1.1]`).
  /// - Enforces **correct placement of special characters** (`.`, `_`, `-`, etc.).
  /// - Rejects emails with **multiple consecutive dots** or missing domain parts.
  ///
  /// ### Returns:
  /// - `true` if the string matches a valid email pattern.
  /// - `false` if the string is null, empty, or incorrectly formatted.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String email1 = "john.doe@example.com";
  /// bool isValid1 = email1.validateEmailEnhanced(); // true
  ///
  /// String email2 = "user+alias@sub.domain.com";
  /// bool isValid2 = email2.validateEmailEnhanced(); // true
  ///
  /// String email3 = "invalid.email@com";
  /// bool isValid3 = email3.validateEmailEnhanced(); // false
  ///
  /// String email4 = "user@.invalid.com";
  /// bool isValid4 = email4.validateEmailEnhanced(); // false
  /// ```
  ///
  /// This method provides a more **accurate and reliable** email validation
  /// compared to simpler regex patterns. It is recommended when strict email
  /// format verification is needed, such as during **user registration** or
  /// **form validation** in Flutter applications.
  bool validateEmailEnhanced() => hasMatch(this, RegExpPatterns.emailEnhanced);
}

extension PhoneNumberValidation on String {
  /// Validates whether the string is a **valid phone number**.
  ///
  /// This method checks if the phone number consists of **8 to 13 numeric digits**.
  /// It does **not** allow special characters, spaces, or country codes.
  ///
  /// ### Returns:
  /// - `true` if the phone number contains **only digits** (8 to 13 characters long).
  /// - `false` otherwise.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String phone1 = "9876543210";
  /// bool isValid1 = phone1.validatePhone(); // true
  ///
  /// String phone2 = "12345";
  /// bool isValid2 = phone2.validatePhone(); // false (too short)
  ///
  /// String phone3 = "+919876543210";
  /// bool isValid3 = phone3.validatePhone(); // false (contains country code)
  /// ```
  bool validatePhone() => hasMatch(this, r'(^[0-9]{8,13}$)');

  /// Validates whether the string is a **valid phone number with an optional country code**.
  ///
  /// This method allows **10 to 15 digits**, optionally prefixed with a **country code**
  /// (`+` followed by 1-3 digits). It ensures that the main number consists only of digits.
  ///
  /// ### Returns:
  /// - `true` if the phone number is properly formatted with or without a country code.
  /// - `false` otherwise.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String phone1 = "+919876543210";
  /// bool isValid1 = phone1.validatePhoneWithCountryCode(); // true
  ///
  /// String phone2 = "0987654321";
  /// bool isValid2 = phone2.validatePhoneWithCountryCode(); // true
  ///
  /// String phone3 = "+1-800-123-4567";
  /// bool isValid3 = phone3.validatePhoneWithCountryCode(); // false (invalid characters)
  /// ```
  bool validatePhoneWithCountryCode() =>
      hasMatch(this, r'^(\+?\d{1,3})?[\d]{10,15}$');
}

extension PasswordValidation on String {
  /// Validates whether the string meets password strength requirements.
  ///
  /// This method allows customization for password strength, including:
  /// - **Minimum Length** (`minLength`) → default is **6**.
  /// - **Uppercase Character Count** (`uppercaseCharCount`) → default is **0** (not required).
  /// - **Lowercase Character Count** (`lowercaseCharCount`) → default is **0** (not required).
  /// - **Numeric Character Count** (`numericCharCount`) → default is **0** (not required).
  /// - **Special Character Count** (`specialCharCount`) → default is **0** (not required).
  ///
  /// A password is valid if it **meets all specified conditions**.
  ///
  /// ### Returns:
  /// - `true` if the password satisfies all conditions.
  /// - `false` otherwise.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String password1 = "Secure123!";
  /// bool isValid1 = password1.isPasswordValidator(
  ///   minLength: 8,
  ///   uppercaseCharCount: 1,
  ///   lowercaseCharCount: 1,
  ///   numericCharCount: 1,
  ///   specialCharCount: 1,
  /// ); // true
  ///
  /// String password2 = "abc123";
  /// bool isValid2 = password2.isPasswordValidator(
  ///   minLength: 8,
  ///   uppercaseCharCount: 1,
  /// ); // false (too short, missing uppercase)
  ///
  /// String password3 = "P@ssw0rd";
  /// bool isValid3 = password3.isPasswordValidator(
  ///   minLength: 6,
  ///   specialCharCount: 1,
  /// ); // true
  /// ```
  ///
  /// ### Edge Cases:
  /// - Password **must not contain spaces**.
  /// - Default **minimum length is 6**, but can be adjusted.
  bool isPasswordValidator(
      {int minLength = 6,
      int uppercaseCharCount = 0,
      int lowercaseCharCount = 0,
      int numericCharCount = 0,
      int specialCharCount = 0}) {
    if (isEmptyOrNull) return false;
    if (this.contains(' ')) return false;
    if (minLength != 0 &&
        !Validator.hasMinimumLength(this, minLength == 0 ? 6 : minLength)) {
      return false;
    }
    if (uppercaseCharCount != 0 &&
        !Validator.hasMinimumUppercase(this, uppercaseCharCount)) {
      return false;
    }
    if (lowercaseCharCount != 0 &&
        !Validator.hasMinimumLowercase(this, lowercaseCharCount)) {
      return false;
    }
    if (numericCharCount != 0 &&
        !Validator.hasMinimumNumericCharacters(this, numericCharCount)) {
      return false;
    }
    if (specialCharCount != 0 &&
        !Validator.hasMinimumSpecialCharacters(this, specialCharCount)) {
      return false;
    }
    return true;
  }
}

extension UsernameValidation on String {
  /// Checks whether the string is a valid username.
  ///
  /// ### Validation Rules:
  /// - Must be **at least 3 characters** long.
  /// - Can only contain **letters (A-Z, a-z)**, **numbers (0-9)**, and **underscores (_)**
  /// - **Spaces or special characters are NOT allowed**.
  ///
  /// ### Returns:
  /// - `true` if the username is valid.
  /// - `false` if the username is invalid.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String username1 = "user_123";
  /// bool isValid1 = username1.isValidUsername(); // true
  ///
  /// String username2 = "ab";
  /// bool isValid2 = username2.isValidUsername(); // false (too short)
  ///
  /// String username3 = "user@name";
  /// bool isValid3 = username3.isValidUsername(); // false (contains @ symbol)
  ///
  /// String username4 = "User_Name_99";
  /// bool isValid4 = username4.isValidUsername(); // true
  /// ```
  ///
  /// ### Edge Cases:
  /// - **Usernames shorter than 3 characters are invalid**.
  /// - **Usernames with spaces or special characters (e.g., `@, #, $, %`) are invalid**.
  /// - **Usernames with only numbers are valid, e.g., `"12345"`**.
  bool isValidUsername() {
    return RegExp(r'^[a-zA-Z0-9_]{3,}$').hasMatch(this);
  }
}

extension PasswordStrength on String {
  /// Determines the **strength of a password**.
  ///
  /// ### Strength Levels:
  /// - **Weak** → Password is shorter than **6 characters**.
  /// - **Medium** → At least **6 characters** and contains:
  ///   - One **uppercase letter**
  ///   - One **lowercase letter**
  ///   - One **number**
  /// - **Strong** → At least **8 characters** and contains:
  ///   - One **uppercase letter**
  ///   - One **lowercase letter**
  ///   - One **number**
  ///   - One **special character** (`@$!%*?&`)
  ///
  /// ---
  /// ### **Example Usage:**
  /// ```dart
  /// print("abc".passwordStrength());          // Weak (too short)
  /// print("Abc123".passwordStrength());       // Medium (meets basic rules)
  /// print("StrongP@ssword1".passwordStrength()); // Strong (meets all conditions)
  /// print("password".passwordStrength());     // Weak (no numbers or uppercase)
  /// ```
  ///
  /// ---
  /// ### **Edge Cases:**
  /// - Passwords **without uppercase, lowercase, or numbers** remain weak.
  /// - Passwords with **special characters but fewer than 8 characters** are still **medium**.
  /// - The method does **not enforce** extra security policies like no repeated characters.
  ///
  /// ---
  String passwordStrength() {
    if (length < 6) return 'Weak';
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(this)) {
      return 'Medium';
    }
    if (RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$')
        .hasMatch(this)) {
      return 'Strong';
    }
    return 'Weak';
  }
}

extension PhoneExtraction on String {
  /// Extracts the **country code** and **phone number** from a formatted string.
  ///
  /// ### Returns:
  /// A `Map<String, String>` with:
  /// - `"countryCode"` → The extracted **country code** (e.g., `+1`, `+91`, etc.).
  /// - `"number"` → The extracted **local phone number**.
  ///
  /// If the input does **not match** the expected phone number format, an **empty map `{}`** is returned.
  ///
  /// ---
  /// ### **Example Usage:**
  /// ```dart
  /// String phone1 = "+911234567890";
  /// var extracted1 = phone1.extractPhoneNumber;
  /// print(extracted1); // { "countryCode": "+91", "number": "1234567890" }
  ///
  /// String phone2 = "9876543210"; // No country code
  /// var extracted2 = phone2.extractPhoneNumber;
  /// print(extracted2); // { "countryCode": "", "number": "9876543210" }
  ///
  /// String phone3 = "+12025550123"; // US number
  /// var extracted3 = phone3.extractPhoneNumber;
  /// print(extracted3); // { "countryCode": "+1", "number": "2025550123" }
  ///
  /// String invalidPhone = "12-345-678";
  /// var extractedInvalid = invalidPhone.extractPhoneNumber;
  /// print(extractedInvalid); // {}
  /// ```
  ///
  /// ---
  /// ### **Edge Cases:**
  /// - **Supports international formats** like `+91XXXXXXXXXX`, `+12025550123`, etc.
  /// - **Handles numbers without country codes**, returning an empty string for `"countryCode"`.
  /// - **Returns `{}` for invalid formats**, such as containing **letters, dashes, or special characters**.
  ///
  Map<String, String> extractPhoneNumber() {
    final match = RegExp(r'^(\+?\d{1,3})?([\d]{10,15})$').firstMatch(this);
    if (match == null) return {};
    return {
      'countryCode': match.group(1) ?? '',
      'number': match.group(2) ?? '',
    };
  }
}
