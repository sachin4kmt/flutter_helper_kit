extension IterableExtension<T> on Iterable<T> {
  /// Groups elements by the given [key] function.
  Map<K, List<T>> groupBy<K>(K Function(T element) key) {
    final Map<K, List<T>> grouped = {};
    for (final element in this) {
      final keyValue = key(element);
      grouped.putIfAbsent(keyValue, () => []).add(element);
    }
    return grouped;
  }

  /// Returns the element that yields the highest value based on the given [selector].
  T? maxBy<K extends Comparable>(K Function(T element) selector) {
    if (isEmpty) return null;

    T? maxElement;
    K? maxKey;

    for (final element in this) {
      final key = selector(element);
      if ((maxKey == null || key.compareTo(maxKey) > 0)) {
        maxElement = element;
        maxKey = key;
      }
    }
    return maxElement;
  }
}

///Element may be null
extension NullableElementIterableExtension<T> on Iterable<T?> {
  /// Returns the element that yields the highest value based on the given [selector].
  T? maxBy<K extends Comparable>(K Function(T element) selector) {
    if (isEmpty) return null;

    T? maxElement;
    K? maxKey;

    for (final element in this.whereType<T>()) {
      // Filters out nulls
      final key = selector(element);
      if (maxKey == null || key.compareTo(maxKey) > 0) {
        maxElement = element;
        maxKey = key;
      }
    }
    return maxElement;
  }
}

///List or Element may be null
extension NullableIterableExtension<T> on Iterable<T?>? {
  /// Returns an empty iterable if this is null.
  Iterable<T> validate() => this?.whereType<T>() ?? const Iterable.empty();

  /// Maps each non-null element using [mapper].
  Iterable<R> mapNonNull<R>(R Function(T element) mapper) =>
      validate().map(mapper);

  /// Returns the first non-null element or null if none exists.
  ///   final numbers = [null, null, 5, 10, null];
  ///   final emptyList = null;
  ///
  ///   print(numbers.firstNonNull()); // Output: 5
  ///   print(emptyList.firstNonNull()); // Output: null
  T? firstNonNull() {
    final nonNullIterable = this?.whereType<T>();
    return nonNullIterable != null && nonNullIterable.isNotEmpty
        ? nonNullIterable.first
        : null;
  }

  /// Returns a new iterable with duplicates removed, preserving nulls.
  Iterable<T?> distinct() =>
      this == null ? Iterable.empty() : validate().toSet();

  /// Groups non-null elements by the given [key] function.
  Map<K, List<T>> groupNonNullBy<K>(K Function(T element) key) =>
      validate().groupBy(key);

  /// Finds the maximum value based on a selector or returns null if empty or all null.
  T? maxBy<K extends Comparable<K>>(K Function(T element) selector) =>
      validate().maxBy(selector);
  // T? maxBy<K extends Comparable<K>>(K Function(T element) selector) => validate().reduceOrNull((a, b) => selector(a).compareTo(selector(b)) >= 0 ? a : b);

  /// Finds the minimum value based on a selector or returns null if empty or all null.
  T? minBy<K extends Comparable<K>>(K Function(T element) selector) =>
      validate().reduceOrNull(
          (a, b) => selector(a).compareTo(selector(b)) <= 0 ? a : b);

  /// Filters the elements based on [predicate], ignoring nulls.
  Iterable<T> whereNonNull(bool Function(T element) predicate) =>
      validate().where(predicate);

  /// Applies [action] to each non-null element.
  void forEachNonNull(void Function(T element) action) {
    validate().forEach(action);
  }

  /// Returns true if all non-null elements satisfy [predicate].
  bool allNonNull(bool Function(T element) predicate) =>
      validate().every(predicate);

  /// Returns true if any non-null element satisfies [predicate].
  bool anyNonNull(bool Function(T element) predicate) =>
      validate().any(predicate);

  /// Reduces non-null elements to a single value or returns null if empty.
  T? reduceOrNull(T Function(T value, T element) combine) {
    final nonNullList = validate();
    if (nonNullList.isEmpty) return null;
    return nonNullList.reduce(combine);
  }

  /// Joins the non-null elements into a string with the given [separator].
  String joinNonNull([String separator = '']) => validate().join(separator);

  /// Returns a set of elements that are common between this iterable and [other].
  Iterable<T> intersectWith(Iterable<T> other) =>
      validate().toSet().intersection(other.toSet());

  /// Returns a set of elements that are unique to this iterable compared to [other].
  Iterable<T> differenceFrom(Iterable<T> other) =>
      validate().toSet().difference(other.toSet());
}
