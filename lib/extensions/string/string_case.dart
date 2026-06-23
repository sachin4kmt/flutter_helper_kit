
/// Extension to convert strings into different cases.
/// Supports snake_case, camelCase, PascalCase, kebab-case,
/// SCREAMING_SNAKE_CASE, Title Case, and Sentence case.
extension StringCaseExtensions on String {
  /// Converts string to `snake_case`.
  /// Example: `"EditItem"` → `"edit_item"`
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m[1]}_${m[2]}',
    ).replaceAll(RegExp(r'\s+'), '_').toLowerCase();
  }

  /// Converts string to `camelCase`.
  /// Example: `"edit item"` → `"editItem"`
  String toCamelCase() {
    final words = _splitWords();
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((w) => _capitalize(w)).join();
  }

  /// Converts string to `PascalCase`.
  /// Example: `"edit item"` → `"EditItem"`
  String toPascalCase() {
    final words = _splitWords();
    return words.map((w) => _capitalize(w)).join();
  }

  /// Converts string to `kebab-case`.
  /// Example: `"Edit Item"` → `"edit-item"`
  String toKebabCase() {
    return _splitWords().join('-').toLowerCase();
  }

  /// Converts string to `SCREAMING_SNAKE_CASE`.
  /// Example: `"Edit Item"` → `"EDIT_ITEM"`
  String toScreamingSnakeCase() {
    return _splitWords().join('_').toUpperCase();
  }

  /// Converts string to Title Case (capitalize every word).
  /// Example: `"edit_item"` → `"Edit Item"`
  String toTitleCase() {
    return _splitWords().map((w) => _capitalize(w)).join(' ');
  }

  /// Converts string to Sentence case (capitalize only the first word).
  /// Example: `"edit_item now"` → `"Edit item now"`
  String toSentenceCase() {
    final lower = toLowerCase();
    if (lower.isEmpty) return lower;
    return lower[0].toUpperCase() + lower.substring(1);
  }

  // ----------------
  // 🔒 Internal helpers
  // ----------------

  /// Splits string into words by underscores, hyphens, camelCase, or spaces.
  List<String> _splitWords() {
    return replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
          (m) => '${m[1]} ${m[2]}',
    ).replaceAll(RegExp(r'[_\-\s]+'), ' ')
        .trim()
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();
  }

  /// Capitalizes the first letter of a word.
  String _capitalize(String word) =>
      word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase();
}