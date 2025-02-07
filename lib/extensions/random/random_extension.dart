import 'dart:math' as math;

extension RandomExtension on math.Random {
  /// Generates a random lorem ipsum text containing a specified number of words.
  ///
  /// - If [limit] is provided, the generated text will contain at most [limit] words.
  /// - If no [limit] is provided, it returns the full lorem ipsum paragraph.
  ///
  /// Example:
  /// ```dart
  /// final random = Random();
  /// print(random.generateLoremIpsumWords(10)); // Outputs: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
  /// ```
  String generateLoremIpsumWords([int? limit]) {
    const String paragraph =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
    final List<String> words = paragraph.split(' ');
    String result = '';
    for (int i = 0; i < (limit ?? words.length); i++) {
      result += '${words[i % words.length]} ';
    }
    return result.trim();
  }

  /// Generates a random past date from today, up to a maximum number of days.
  ///
  /// - Defaults to a random date within the last 5 years (1825 days).
  /// - The [days] parameter allows customization of the range.
  ///
  /// Example:
  /// ```dart
  /// final random = Random();
  /// print(random.pastDate()); // Outputs: A random past date within the last 5 years
  /// print(random.pastDate(30)); // Outputs: A random past date within the last 30 days
  /// ```
  DateTime pastDate([int days = 5 * 365]) {
    final int randomDays = nextInt(days);
    final DateTime randomDate = DateTime.now()
        .subtract(Duration(days: randomDays, seconds: nextInt(60 * 60 * 24)));
    return randomDate;
  }

  /// Generates a random future date from today, up to a maximum number of days.
  ///
  /// - Defaults to a random date within the next 5 years (1825 days).
  /// - The [days] parameter allows customization of the range.
  ///
  /// Example:
  /// ```dart
  /// final random = Random();
  /// print(random.futureDate()); // Outputs: A random future date within the next 5 years
  /// print(random.futureDate(60)); // Outputs: A random future date within the next 60 days
  /// ```
  DateTime futureDate([int days = 5 * 365]) {
    final int randomDays = nextInt(days);
    final DateTime randomDate = DateTime.now()
        .add(Duration(days: randomDays, seconds: nextInt(60 * 60 * 24)));
    return randomDate;
  }
}
