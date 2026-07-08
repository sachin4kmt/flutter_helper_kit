import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/extensions/number/smart_round_to_string.dart';
import 'package:flutter_helper_kit/extensions/string/string_extension.dart';

part 'map_get_or_default.dart';

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
  bool get isNullOrEmpty => this == null || this!.isEmpty;

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
  bool get isNotNullOrEmpty => !(isNullOrEmpty);

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
    if (isNullOrEmpty) return Map<K, V>.from(map ?? {});
    if (map.isNullOrEmpty) return Map<K, V>.from(this!);
    return {...this!, ...map!};
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
    }
    return map;
  }
}
