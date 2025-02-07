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

///List may be null
/// Extension methods for nullable [Iterable] to perform common operations
/// safely, checking for null or empty conditions first.
extension NullableIterableExtension<T> on Iterable<T>? {
  /// Returns `true` if this nullable iterable is either `null` or empty.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers;
  /// bool result = numbers.isNullOrEmpty;  // true
  /// ```
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `false` if this nullable iterable is either `null` or empty.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers;
  /// bool result = numbers.isNotNullOrEmpty;  // false
  /// ```
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns the first element of the iterable or `null` if empty or null.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3];
  /// int? result = numbers.firstOrNull;  // 1
  /// ```
  T? get firstOrNull => isNullOrEmpty ? null : this!.first;

  /// Returns the first element matching the given [predicate], or `null`
  /// if no match was found.
  ///
  /// Example:
  /// ```dart
  /// Iterable<String>? words = ["Flutter", "Dart", "Java"];
  /// String? result = words.firstWhereOrNull((word) => word.length == 5);  // "Dart"
  /// ```
  T? firstWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) {
      return null;
    }
    final list = this!.where(test);
    return list.isEmpty ? null : list.first;
  }

  /// Returns the last element matching the given [predicate], or `null`
  /// if no match was found.
  ///
  /// Example:
  /// ```dart
  /// Iterable<String>? words = ["Flutter", "Dart", "Java"];
  /// String? result = words.lastWhereOrNull((word) => word.length == 3);  // "Dart"
  /// ```
  T? lastWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) {
      return null;
    }
    final list = this!.where(test);
    return list.isEmpty ? null : list.last;
  }

  /// Removes the first element in the list and returns a new list.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3];
  /// List<int> result = numbers.removeFirstElement();  // [2, 3]
  /// ```
  List<T> removeFirstElement() {
    List<T> list = [];
    if (isNullOrEmpty) return list;
    var thisList = this!.toList();
    return thisList..removeAt(0);
  }

  /// Removes the last element in the list and returns a new list.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3];
  /// List<int> result = numbers.removeLastElement();  // [1, 2]
  /// ```
  List<T> removeLastElement() {
    List<T> list = [];
    if (isNullOrEmpty) return list;
    var thisList = this!.toList();
    return thisList..removeAt(thisList.length - 1);
  }

  /// Returns the count of elements that match the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3, 4, 5];
  /// int count = numbers.countWhere((number) => number > 3);  // 2
  /// ```
  int countWhere(bool Function(T element) predicate) {
    if (isNullOrEmpty) return 0;
    return this!.where(predicate).length;
  }

  /// Returns a list containing the first [n] elements.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3, 4, 5];
  /// List<int> result = numbers.take(3);  // [1, 2, 3]
  /// ```
  List<T> take(int n) {
    if (this == null) return <T>[];
    if (n <= 0) return [];

    var list = <T>[];
    if (this is Iterable) {
      if (n >= this!.length) return this!.toList();

      var count = 0;
      var thisList = this!.toList();
      for (var item in thisList) {
        list.add(item);
        if (++count == n) break;
      }
    }
    return list;
  }

  /// Gets an element at a specific index or returns `null` if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int>? numbers = [1, 2, 3];
  /// int? result = numbers.elementAtOrNull(1);  // 2
  /// ```
  T? elementAtOrNull(int index) {
    if (isNullOrEmpty) {
      return null;
    }
    if (index < this!.length) {
      return this!.elementAt(index);
    } else {
      return null;
    }
  }

  /// Returns a list containing only elements that match the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Iterable<String>? words = ["Flutter", "Dart", "Java"];
  /// Iterable<String> result = words.filterOrNewList((word) => word.length == 5);  // ["Flutter", "Dart"]
  /// ```
  Iterable<T> filterOrNewList(bool Function(T e) fun) {
    if (isNullOrEmpty) {
      return [];
    }
    final result = <T>[];
    for (var element in this!) {
      if (fun(element)) result.add(element);
    }
    return result;
  }

  /// Returns a list containing all elements that do not match the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Iterable<String>? words = ["Flutter", "Dart", "Java"];
  /// Iterable<String> result = words.filterNot((word) => word.length == 3);  // ["Flutter", "Dart"]
  /// ```
  Iterable<T> filterNot(bool Function(T element) fun) {
    if (isNullOrEmpty) {
      return [];
    }
    final result = <T>[];
    for (var element in this!) {
      if (!fun(element)) result.add(element);
    }
    return result;
  }
}

/// Extension methods for nullable [Iterable<T?>] to perform common operations
/// such as finding the element that yields the highest value based on a selector.
extension NullableElementIterableExtension<T> on Iterable<T?> {
  /// Returns the element that yields the highest value based on the given [selector].
  /// If the iterable is empty or all elements are `null`, it returns `null`.
  ///
  /// The [selector] function is used to extract a comparable key from each element.
  /// The element with the highest value based on the selector is returned.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [3, 5, 7, 2, null, 4];
  /// int? result = numbers.maxBy((num) => num!);  // 7
  /// ```
  /// Example with a custom object:
  /// ```dart
  /// class Product {
  ///   final String name;
  ///   final double price;
  ///   Product(this.name, this.price);
  /// }
  ///
  /// Iterable<Product?>? products = [
  ///   Product('Apple', 1.5),
  ///   Product('Banana', 0.8),
  ///   Product('Mango', 2.0),
  ///   null
  /// ];
  /// Product? result = products.maxBy((product) => product?.price ?? 0.0);
  /// print(result?.name);  // Mango
  /// ```
  T? maxBy<K extends Comparable>(K Function(T element) selector) {
    if (isEmpty) return null;

    T? maxElement;
    K? maxKey;

    for (final element in whereType<T>()) {
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
/// Extension methods for nullable [Iterable<T?>?] to provide operations on nullable
/// iterables, such as filtering, mapping, reducing, and working with non-null values.
extension NullableElementNullableIterableExtension<T> on Iterable<T?>? {
  /// Returns an empty iterable if this iterable is `null`, otherwise filters out `null` values.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [null, 2, 3];
  /// print(numbers.validate());  // Output: [2, 3]
  /// ```
  Iterable<T> validate() => this?.whereType<T>() ?? const Iterable.empty();

  /// Maps each non-null element using the provided [mapper] function.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [null, 2, 3];
  /// final mapped = numbers.mapNonNull((num) => num * 2);
  /// print(mapped);  // Output: [4, 6]
  /// ```
  Iterable<R> mapNonNull<R>(R Function(T element) mapper) =>
      validate().map(mapper);

  /// Returns the first non-null element or `null` if none exists.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [null, null, 5, 10, null];
  /// print(numbers.firstNonNull()); // Output: 5
  /// ```
  T? firstNonNull() {
    final nonNullIterable = this?.whereType<T>();
    return nonNullIterable != null && nonNullIterable.isNotEmpty
        ? nonNullIterable.first
        : null;
  }

  /// Returns a new iterable with duplicates removed, preserving nulls.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 2, 3, null, null];
  /// final distinct = numbers.distinct();
  /// print(distinct);  // Output: [1, 2, 3, null]
  /// ```
  Iterable<T?> distinct() =>
      this == null ? Iterable.empty() : validate().toSet();

  /// Groups non-null elements by the given [key] function.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3, 4, null, 2, 1];
  /// var grouped = numbers.groupNonNullBy((num) => num % 2);
  /// print(grouped);  // Output: {1: [1, 3, 1], 0: [2, 4, 2]}
  /// ```
  Map<K, List<T>> groupNonNullBy<K>(K Function(T element) key) =>
      validate().groupBy(key);

  /// Finds the maximum value based on a selector or returns `null` if empty or all `null`.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [3, 5, 2, null];
  /// print(numbers.maxBy((num) => num!)); // Output: 5
  /// ```
  T? maxBy<K extends Comparable<K>>(K Function(T element) selector) =>
      validate().maxBy(selector);

  /// Finds the minimum value based on a selector or returns `null` if empty or all `null`.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [3, 5, 2, null];
  /// print(numbers.minBy((num) => num!)); // Output: 2
  /// ```
  T? minBy<K extends Comparable<K>>(K Function(T element) selector) =>
      validate().reduceOrNull(
          (a, b) => selector(a).compareTo(selector(b)) <= 0 ? a : b);

  /// Filters the elements based on the provided [predicate], ignoring `null` values.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3, null];
  /// final filtered = numbers.whereNonNull((num) => num! > 1);
  /// print(filtered);  // Output: [2, 3]
  /// ```
  Iterable<T> whereNonNull(bool Function(T element) predicate) =>
      validate().where(predicate);

  /// Applies the provided [action] to each non-null element.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3, null];
  /// numbers.forEachNonNull((num) => print(num));  // Output: 1, 2, 3
  /// ```
  void forEachNonNull(void Function(T element) action) {
    validate().forEach(action);
  }

  /// Returns `true` if all non-null elements satisfy the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [2, 4, 6];
  /// print(numbers.allNonNull((num) => num! % 2 == 0)); // Output: true
  /// ```
  bool allNonNull(bool Function(T element) predicate) =>
      validate().every(predicate);

  /// Returns `true` if any non-null element satisfies the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 3, 5];
  /// print(numbers.anyNonNull((num) => num! % 2 == 0)); // Output: false
  /// ```
  bool anyNonNull(bool Function(T element) predicate) =>
      validate().any(predicate);

  /// Reduces non-null elements to a single value or returns `null` if empty.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3, 4];
  /// final sum = numbers.reduceOrNull((a, b) => a + b);
  /// print(sum);  // Output: 10
  /// ```
  T? reduceOrNull(T Function(T value, T element) combine) {
    final nonNullList = validate();
    if (nonNullList.isEmpty) return null;
    return nonNullList.reduce(combine);
  }

  /// Joins the non-null elements into a string with the given [separator].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3, null];
  /// print(numbers.joinNonNull('-'));  // Output: 1-2-3
  /// ```
  String joinNonNull([String separator = '']) => validate().join(separator);

  /// Returns a set of elements that are common between this iterable and [other].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3];
  /// print(numbers.intersectWith([2, 3, 4]));  // Output: {2, 3}
  /// ```
  Iterable<T> intersectWith(Iterable<T> other) =>
      validate().toSet().intersection(other.toSet());

  /// Returns a set of elements that are unique to this iterable compared to [other].
  ///
  /// Example:
  /// ```dart
  /// Iterable<int?>? numbers = [1, 2, 3];
  /// print(numbers.differenceFrom([2, 3, 4]));  // Output: {1}
  /// ```
  Iterable<T> differenceFrom(Iterable<T> other) =>
      validate().toSet().difference(other.toSet());
}
