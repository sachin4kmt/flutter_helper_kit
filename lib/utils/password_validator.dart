
class Validator {
  /// Checks if the password has a minimum length.
  ///
  /// Returns `true` if the length of the [password] is greater than or equal to [minLength],
  /// otherwise returns `false`.
  static bool hasMinimumLength(String password, int minLength) {
    return password.length >= minLength;
  }

  /// Checks if the password has a minimum number of uppercase characters.
  ///
  /// Returns `true` if the [password] contains at least [uppercaseCount] uppercase characters,
  /// otherwise returns `false`.
  static bool hasMinimumUppercase(String password, int uppercaseCount) {
    String pattern = '^(.*?[A-Z]){$uppercaseCount,}';
    return password.contains(RegExp(pattern));
  }

  /// Checks if the password has a minimum number of lowercase characters.
  ///
  /// Returns `true` if the [password] contains at least [lowercaseCount] lowercase characters,
  /// otherwise returns `false`.
  static bool hasMinimumLowercase(String password, int lowercaseCount) {
    String pattern = '^(.*?[a-z]){$lowercaseCount,}';
    return password.contains(RegExp(pattern));
  }

  /// Checks if the password has a minimum number of numeric characters.
  ///
  /// Returns `true` if the [password] contains at least [numericCount] numeric characters,
  /// otherwise returns `false`.
  static bool hasMinimumNumericCharacters(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){$numericCount,}';
    return password.contains(RegExp(pattern));
  }

  /// Checks if the password has a minimum number of special characters.
  ///
  /// Returns `true` if the [password] contains at least [specialCharactersCount] special characters,
  /// otherwise returns `false`.
  static bool hasMinimumSpecialCharacters(String password, int specialCharactersCount) {
    String pattern = r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){$specialCharactersCount,}";
    return password.contains(RegExp(pattern));
  }
}