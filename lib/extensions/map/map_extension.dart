import 'package:flutter_helper_kit/flutter_helper_kit.dart';

///Map
extension MapExtension<K, V> on Map<K, V>? {
  /// Returns `true` if this nullable map is either `null` or empty.
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map1 = null;
  /// print(map1.isNullOrEmpty); // true
  ///
  /// Map<String, int>? map2 = {};
  /// print(map2.isNullOrEmpty); // true
  ///
  /// Map<String, int>? map3 = {"a": 1};
  /// print(map3.isNullOrEmpty); // false
  /// ```
  bool get isNullOrEmpty => this == null || this!.keys.isNullOrEmpty;

  /// Returns `true` if this nullable map is not `null` and contains at least one key-value pair.
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map = {"a": 1};
  /// print(map.isNotNullOrEmpty); // true
  ///
  /// Map<String, int>? emptyMap = {};
  /// print(emptyMap.isNotNullOrEmpty); // false
  ///
  /// Map<String, int>? nullMap = null;
  /// print(nullMap.isNotNullOrEmpty); // false
  /// ```
  bool get isNotNullOrEmpty => !(this.isNullOrEmpty);

  /// Adds an item into the map if the value is not `null` and the key does not exist.
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map = {"a": 1};
  /// map = map.addIfNotNull("b", 2);
  /// print(map); // {a: 1, b: 2}
  ///
  /// map = map.addIfNotNull("b", null);
  /// print(map); // {a: 1, b: 2} (unchanged)
  /// ```
  Map<K, V>? addIfNotNull(K key, V value) {
    if (value != null) this?.putIfAbsent(key, () => value);
    return this;
  }

  /// Returns a new map with all keys' first character capitalized.
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map = {"apple": 1, "banana": 2};
  /// print(map.capitalizeKeysFirstCharacter()); // {Apple: 1, Banana: 2}
  /// ```
  Map<String, V> capitalizeKeysFirstCharacter() {
    if (isNullOrEmpty) return {};
    final map = <String, V>{};
    for (final key in this!.keys) {
      map[key.toString().capitalizeFirstCharacter()] = this?[key] as V;
    }
    return map;
  }

  /// Returns a new map containing only the entries that satisfy the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map = {"a": 1, "b": 2, "c": 3};
  /// print(map.filter((key, value) => value > 1)); // {b: 2, c: 3}
  /// ```
  Map<K, V> filter(bool Function(K key, V value) predicate) {
    if (isNullOrEmpty) return {};
    final map = <K, V>{};
    for (final key in this!.keys) {
      if (predicate(key, this?[key] as V)) {
        map[key] = this?[key] as V;
      }
    }
    return map;
  }

  /// Merges this map with another map.
  /// If a key already exists, the new map's value overrides the existing one.
  ///
  /// Example:
  /// ```dart
  /// Map<String, int>? map1 = {"a": 1, "b": 2};
  /// Map<String, int>? map2 = {"b": 3, "c": 4};
  /// print(map1.updateAndJoin(map2)); // {a: 1, b: 3, c: 4}
  /// ```
  Map<K, V> updateAndJoin(Map<K, V>? map) {
    if (isNullOrEmpty) return map ?? {};
    if (map.isNullOrEmpty) return this ?? {};
    final newMap = this!;
    for (final key in map!.keys) {
      if (this!.containsKey(key)) {
        newMap[key] = map[key] as V;
      } else {
        newMap.addAll({key: map[key] as V});
      }
    }
    return map;
  }
}

extension MapStringKeyExtension<T, V> on Map<String, V>? {
  /// Returns a new map with updated keys based on the provided transformation function.
  ///
  /// If the map is `null` or empty, it returns an empty map `{}`.
  ///
  /// Example:
  /// ```dart
  /// final map = {'framework': "Flutter", 'language': "Dart"};
  /// final newMap = map.updateKeys((key) => "$key's");
  /// print(newMap);
  /// ```
  /// **Output:**
  /// ```dart
  /// {framework's: Flutter, language's: Dart}
  /// ```
  Map<String, V> updateKeys(String Function(String key) newKey) {
    if (isNullOrEmpty) return {};
    final map = <String, V>{};
    for (var key in this!.keys) {
      map.addAll({newKey.call(key): this?[key] as V});
      // map[key] = this?[key] as V;
    }
    return map;
  }
}

/// Returns the element of given key in [Map].
extension MapGetOrDefault<K, V> on Map<K, V> {
  /// Returns the value associated with the given `key`,
  ///
  /// or `defaultValue` if the key does not exists.
  ///
  /// ### Example:
  /// ```dart
  /// final map = {'name', 'John', 'email': 'john@example.com'};
  ///
  /// print(getOrDefault('name', 'Unknown')); // Output: John
  ///
  /// print(getOrDefault('email', 'NA')); // Output: john@example.com
  ///
  /// print(getOrDefault('age', 'undefined')); // Output: undefined
  /// ```
  V? getOrDefault(K key, V? defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;

  /// Returns the integer value associated with the given `key`,
  /// or `defaultValue` if the key does not exist or cannot be converted to `int`.
  ///
  /// ### Example:
  /// ```dart
  /// final map = {'count': '10', 'views': 20};
  ///
  /// print(map.getIntOrDefault('count', 0)); // Output: 10
  ///
  /// print(map.getIntOrDefault('views', 0)); // Output: 20
  ///
  /// print(map.getIntOrDefault('likes', 5)); // Output: 5
  /// ```
  int? getIntOrDefault(K key, int? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    final value = this[key];
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    if (value is num) return value.toInt();
    return defaultValue;
  }

  /// Returns the numeric value associated with the given `key`,
  /// or `defaultValue` if the key does not exist or cannot be converted to `num`.
  ///
  /// ### Example:
  /// ```dart
  /// final map = {'price': '19.99', 'discount': 5};
  ///
  /// print(map.getNumOrDefault('price', 0)); // Output: 19.99
  ///
  /// print(map.getNumOrDefault('discount', 0)); // Output: 5
  ///
  /// print(map.getNumOrDefault('tax', 2.5)); // Output: 2.5
  /// ```
  num? getNumOrDefault(K key, num? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    final value = this[key];

    if (value is num) return value;
    if (value is String) return value.toNum() ?? defaultValue;

    return defaultValue;
  }

  /// Returns the double value associated with the given `key`,
  /// or `defaultValue` if the key does not exist or cannot be converted to `double`.
  ///
  /// ### Example:
  /// ```dart
  /// final map = {'rating': '4.5', 'average': 3.2};
  ///
  /// print(map.getDoubleOrDefault('rating', 0.0)); // Output: 4.5
  ///
  /// print(map.getDoubleOrDefault('average', 0.0)); // Output: 3.2
  ///
  /// print(map.getDoubleOrDefault('score', 1.0)); // Output: 1.0
  /// ```
  double? getDoubleOrDefault(K key, double? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    final value = this[key];
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return value.toDouble() ?? defaultValue;
    return defaultValue;
  }

  /// Returns the string value associated with the given `key`,
  /// or `defaultValue` if the key does not exist.
  ///
  /// ### Example:
  /// ```dart
  /// final map = {'name': 'John', 'age': 30};
  ///
  /// print(map.getStringOrDefault('name', 'Unknown')); // Output: John
  ///
  /// print(map.getStringOrDefault('age', 'N/A')); // Output: 30
  ///
  /// print(map.getStringOrDefault('city', 'Not specified')); // Output: Not specified
  /// ```
  String? getStringOrDefault(K key, String? defaultValue) {
    if (!containsKey(key)) return defaultValue;
    final value = this[key];
    return value?.toString() ?? defaultValue;
  }
}
