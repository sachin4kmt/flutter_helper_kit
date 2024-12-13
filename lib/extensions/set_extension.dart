import 'dart:math';

extension SetExtension<E> on Set<E> {
  /// Returns a random element from this set.
  E random() {
    if (isEmpty) throw StateError('Set is empty.');
    final random = Random();
    return elementAt(random.nextInt(length));
  }

  /// Returns a random element from this set, or null if this set is empty.
  E? randomOrNull() {
    if (isEmpty) return null;
    final random = Random();
    return elementAt(random.nextInt(length));
  }

  /// Returns a new set with elements that satisfy the given [predicate].
  Set<E> whereSet(bool Function(E element) predicate) {
    return Set.from(where(predicate));
  }

  /// Returns a new set with elements transformed by the given [mapper].
  Set<T> mapSet<T>(T Function(E element) mapper) {
    return Set.from(map(mapper));
  }

  /// Returns true if any element matches the given [predicate].
  bool any(bool Function(E element) predicate) {
    for (final element in this) {
      if (predicate(element)) return true;
    }
    return false;
  }

  /// Returns true if all elements match the given [predicate].
  bool all(bool Function(E element) predicate) {
    for (final element in this) {
      if (!predicate(element)) return false;
    }
    return true;
  }

  /// Returns true if none of the elements match the given [predicate].
  bool none(bool Function(E element) predicate) => !any(predicate);

  /// Returns a new set with [element] added if it's not null.
  Set<E> addIfNotNull(E? element) {
    if (element == null) return this;
    return {...this, element};
  }

  /// Returns a new set with all non-null elements from [elements] added.
  Set<E> addAllIfNotNull(Iterable<E?> elements) {
    return {...this, ...elements.whereType<E>()};
  }

  /// Returns the first element that satisfies the given [predicate], or null if none found.
  E? firstWhereOrNull(bool Function(E element) predicate) {
    for (final element in this) {
      if (predicate(element)) return element;
    }
    return null;
  }

  /// Returns a new set with elements at the specified indices.
  Set<E> slice(int start, [int? end]) {
    final list = toList();
    end ??= list.length;
    return Set.from(list.sublist(start, end));
  }

  /// Returns true if this set contains all elements from [other].
  bool containsAll(Iterable<E> other) {
    return other.every(contains);
  }

  /// Returns true if this set contains any element from [other].
  bool containsAny(Iterable<E> other) {
    return other.any(contains);
  }

  /// Returns a new set with elements grouped by the given [key] function.
  Map<K, Set<E>> groupBy<K>(K Function(E element) key) {
    final result = <K, Set<E>>{};
    for (final element in this) {
      final k = key(element);
      (result[k] ??= {}).add(element);
    }
    return result;
  }

  /// Returns a new set with duplicates removed based on the given [key] function.
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
  Set<E> sorted([int Function(E a, E b)? compare]) {
    final list = toList()..sort(compare);
    return Set.from(list);
  }

  /// Returns a new set with elements sorted by the given [key] function.
  Set<E> sortedBy<K extends Comparable<K>>(K Function(E element) key) {
    return sorted((a, b) => key(a).compareTo(key(b)));
  }

  /// Returns a new set with elements sorted in descending order by the given [key] function.
  Set<E> sortedByDescending<K extends Comparable<K>>(
      K Function(E element) key) {
    return sorted((a, b) => key(b).compareTo(key(a)));
  }
}
