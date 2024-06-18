
import 'package:flutter_helper_kit/extensions/list_extension.dart';
import 'package:flutter_helper_kit/extensions/string_extension.dart';

///Map
extension MapExtension<K, V> on Map<K, V>? {



  /// Returns `true` if this nullable iterable is either `null` or empty.
  bool get isNullOrEmpty => this == null || this!.keys.isNullOrEmpty;

  ///Add item into map if value isn't null
  ///Add item into map if key not exist
  Map<K, V>? addIfNotNull(K key, V value) {
    if (value != null) this?.putIfAbsent(key, () => value);
    return this;
  }

  ///Return value or null from Map
  // V? getIfExist(K key) {
  //   if (isNullOrEmpty) return null;
  //   if (this!.keys.contains(key)) {
  //     return this?[key];
  //   }
  //   return null;
  // }

  /// Capitalize all keys First Character in the map.
  /// Returns a new map with capitalized keys.
  Map<String, V> get capitalizeKeysFirstCharacter {
    if (isNullOrEmpty) return {};
    final map = <String, V>{};
    for (final key in this!.keys) {
      map[key.toString().capitalizeFirstCharacter] = this?[key] as V;
    }
    return map;
  }

  /// Returns a new map with all entries that satisfy the given [predicate].
  /// The entries in the resulting map preserve the order of the original map.
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

  ///Returns a new map with two map join
  ///if key already exist then passing map value override
  Map<K, V> updateAndJoin(Map<K, V>? map) {
    if (isNullOrEmpty) return map??{};
    if (map.isNullOrEmpty) return this??{};
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
  ///Returns a new map with new keys default blank map if null.
  ///Example: final map= {'framework': "Flutter", 'Language': "Dart"};
  ///final newMap= map.updateKeys((key) => key+"\'s");
  /// print(newMap);
  /// output: {framework's: Flutter, Language's: Dart}
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
