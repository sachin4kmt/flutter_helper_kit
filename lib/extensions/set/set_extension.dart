import 'dart:math';

extension SetExtension<E> on Set<E> {
  /// Returns a random element from this set.
  ///
  /// Throws a [StateError] if the set is empty.
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3, 4, 5};
  /// print(set.random()); // Outputs a random element from the set
  /// ```
  E random() {
    if (isEmpty) throw StateError('Set is empty.');
    final random = Random();
    return elementAt(random.nextInt(length));
  }

  /// Returns a random element from this set, or null if the set is empty.
  ///
  /// Example:
  /// ```dart
  /// final set = <int>{};
  /// print(set.randomOrNull()); // Outputs null
  /// ```
  E? randomOrNull() {
    if (isEmpty) return null;
    final random = Random();
    return elementAt(random.nextInt(length));
  }

  /// Returns a new set containing elements that satisfy the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3, 4, 5};
  /// print(set.whereSet((e) => e.isEven)); // Outputs {2, 4}
  /// ```
  Set<E> whereSet(bool Function(E element) predicate) {
    return Set.from(where(predicate));
  }

  /// Returns a new set containing elements transformed by the given [mapper].
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3};
  /// print(set.mapSet((e) => e * 2)); // Outputs {2, 4, 6}
  /// ```
  Set<T> mapSet<T>(T Function(E element) mapper) {
    return Set.from(map(mapper));
  }

  /// Returns `true` if any element in the set satisfies the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final numbers = {1, 2, 3, 4, 5};
  /// final hasEven = numbers.any((n) => n.isEven); // true
  /// ```
  bool any(bool Function(E element) predicate) {
    for (final element in this) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Returns `true` if all elements in the set satisfy the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final numbers = {2, 4, 6};
  /// final allEven = numbers.all((n) => n.isEven); // true
  /// ```
  bool all(bool Function(E element) predicate) {
    for (final element in this) {
      if (!predicate(element)) return false;
    }
    return true;
  }

  /// Returns `true` if none of the elements in the set satisfy the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final numbers = {1, 3, 5};
  /// final hasNoEven = numbers.none((n) => n.isEven); // true
  /// ```
  bool none(bool Function(E element) predicate) => !any(predicate);

  /// Returns a new set with [element] added if it's not null.
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3};
  /// print(set.addIfNotNull(4)); // Outputs {1, 2, 3, 4}
  /// ```
  Set<E> addIfNotNull(E? element) {
    if (element == null) return this;
    return {...this, element};
  }

  /// Returns a new set with all non-null elements from [elements] added.
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2};
  /// final updatedSet = set.addAllIfNotNull([3, null, 4]);
  /// print(updatedSet); // {1, 2, 3, 4}
  /// ```
  Set<E> addAllIfNotNull(Iterable<E?> elements) {
    return {...this, ...elements.whereType<E>()};
  }

  /// Returns the first element that satisfies the given [predicate], or null if none found.
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3};
  /// print(set.firstWhereOrNull((e) => e > 2)); // 3
  /// print(set.firstWhereOrNull((e) => e > 5)); // null
  /// ```
  E? firstWhereOrNull(bool Function(E element) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Returns a new set with elements at the specified indices.
  ///
  /// Example:
  /// ```dart
  /// final set = {10, 20, 30, 40, 50};
  /// print(set.slice(1, 3)); // {20, 30}
  /// ```
  Set<E> slice(int start, [int? end]) {
    final list = toList();
    end ??= list.length;
    return Set.from(list.sublist(start, end));
  }

  /// Returns true if this set contains all elements from [other].
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3, 4};
  /// print(set.containsAll({2, 3})); // true
  /// print(set.containsAll({5, 6})); // false
  /// ```
  bool containsAll(Iterable<E> other) {
    return other.every(contains);
  }

  /// Returns true if this set contains any element from [other].
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3, 4};
  /// print(set.containsAny({3, 5})); // true
  /// print(set.containsAny({6, 7})); // false
  /// ```
  bool containsAny(Iterable<E> other) {
    return other.any(contains);
  }

  /// Returns a new set with elements grouped by the given [key] function.
  ///
  /// Example:
  /// ```dart
  /// final set = {'apple', 'banana', 'cherry', 'avocado'};
  /// print(set.groupBy((e) => e[0]));
  /// // {a: {apple, avocado}, b: {banana}, c: {cherry}}
  /// ```
  Map<K, Set<E>> groupBy<K>(K Function(E element) key) {
    final result = <K, Set<E>>{};
    for (final element in this) {
      final k = key(element);
      (result[k] ??= {}).add(element);
    }
    return result;
  }

  /// Returns a new set with duplicates removed based on the given [key] function.
  ///
  /// Example:
  /// ```dart
  /// final set = {'apple', 'banana', 'avocado'};
  /// print(set.distinctBy((e) => e[0])); // {apple, banana}
  /// ```
  Set<E> distinctBy<K>(K Function(E element) key) {
    final result = <E>{};
    final keys = <K>{};
    for (final element in this) {
      final k = key(element);
      if (keys.add(k)) {
        result.add(element);
      }
    }
    return result;
  }

  /// Splits the set into chunks of the given [size].
  ///
  /// Example:
  /// ```dart
  /// final set = {1, 2, 3, 4, 5};
  /// print(set.chunked(2)); // ({1, 2}, {3, 4}, {5})
  /// ```
  Iterable<Set<E>> chunked(int size) sync* {
    if (size <= 0) throw ArgumentError('Size must be positive');
    final iterator = this.iterator;
    while (iterator.moveNext()) {
      final chunk = <E>{};
      do {
        chunk.add(iterator.current);
      } while (chunk.length < size && iterator.moveNext());
      yield chunk;
    }
  }

  /// Returns a new set with elements sorted by the given [compare] function.
  ///
  /// Example:
  /// ```dart
  /// final set = {3, 1, 2};
  /// print(set.sorted()); // {1, 2, 3}
  /// ```
  Set<E> sorted([int Function(E a, E b)? compare]) {
    final list = toList()..sort(compare);
    return Set.from(list);
  }

  /// Returns a new set with elements sorted by the given [key] function.
  ///
  /// Example:
  /// ```dart
  /// final set = {'apple', 'banana', 'cherry'};
  /// print(set.sortedBy((e) => e.length)); // {apple, cherry, banana}
  /// ```
  Set<E> sortedBy<K extends Comparable<K>>(K Function(E element) key) {
    return sorted((a, b) => key(a).compareTo(key(b)));
  }

  /// Returns a new set with elements sorted in descending order by the given [key] function.
  ///
  /// Example:
  /// ```dart
  /// final set = {'apple', 'banana', 'cherry'};
  /// print(set.sortedByDescending((e) => e.length)); // {banana, cherry, apple}
  /// ```
  Set<E> sortedByDescending<K extends Comparable<K>>(
      K Function(E element) key) {
    return sorted((a, b) => key(b).compareTo(key(a)));
  }
}
