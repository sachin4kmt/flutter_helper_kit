import 'dart:math' as math;
import 'package:flutter/material.dart';

extension ListExtension<T> on List<T>? {
  /// Returns `true` if this list is either `null` or empty.
  /// ```dart
  /// List<int>? list = [];
  /// print(list.isNullOrEmpty); // true
  /// ```
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if this list is neither `null` nor empty.
  /// ```dart
  /// List<int>? list = [1, 2, 3];
  /// print(list.isNotNullOrEmpty); // true
  /// ```
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns the first element or `null` if the list is empty or null.
  /// ```dart
  /// List<String>? list = ["Flutter", "Dart"];
  /// print(list.firstOrNull); // Flutter
  /// ```
  T? get firstOrNull => isNullOrEmpty ? null : this!.first;

  /// Returns the first element that satisfies the predicate or `null` if none match.
  /// ```dart
  /// List<String>? list = ["Flutter", "Dart", "Android"];
  /// print(list.firstWhereOrNull((e) => e.startsWith("D"))); // Dart
  /// ```
  T? firstWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) return null;
    return this!.where(test).isEmpty ? null : this!.firstWhere(test);
  }

  /// Returns the last element matching the given [predicate], or null if element was not found.
  ///  ["Flutter", "Dart", "Java", "IOS", "Android","web"].lastOrNullIf((it) => it.length == 9); // null
  ///  ["Flutter", "Dart", "Java", "IOS", "Android","web"].lastOrNullIf((it) => it.length == 3); // web
  T? lastWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) {
      return null;
    }
    final list = this!.where(test);
    return list.isEmpty ? null : list.last;
  }

  /// Removes the first element from the list.
  ///
  /// Returns a new list without the first element. If the list is empty or null, an empty list is returned.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3, 4];
  /// print(list.removeFirstElement()); // Output: [2, 3, 4]
  /// ```
  List<T> removeFirstElement() {
    if (isNullOrEmpty) return [];
    var thisList = List<T>.from(this!);
    thisList.removeAt(0);
    return thisList;
  }

  /// Removes the last element from the list.
  ///
  /// Returns a new list without the last element. If the list is empty or null, an empty list is returned.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3, 4];
  /// print(list.removeLastElement()); // Output: [1, 2, 3]
  /// ```
  List<T> removeLastElement() {
    if (isNullOrEmpty) return [];
    var thisList = List<T>.from(this!);
    thisList.removeAt(thisList.length - 1);
    return thisList;
  }

  /// Returns the count of elements that match the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3, 4, 5];
  /// print(list.countWhere((e) => e > 2)); // Output: 3
  /// ```
  int countWhere(bool Function(T element) predicate) {
    if (isNullOrEmpty) return 0;
    return this!.where(predicate).length;
  }

  /// Returns a new list containing the first [n] elements.
  ///
  /// If [n] is greater than the list length, returns the full list.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3, 4, 5];
  /// print(list.take(3)); // Output: [1, 2, 3]
  /// ```
  List<T> take(int n) {
    if (this == null || n <= 0) return [];
    return this!.take(n).toList();
  }

  /// Returns the element at the specified [index], or `null` if the index is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// var list = ["A", "B", "C"];
  /// print(list.elementAtOrNull(1)); // Output: "B"
  /// print(list.elementAtOrNull(5)); // Output: null
  /// ```
  T? elementAtOrNull(int index) {
    if (isNullOrEmpty || index >= this!.length || index < 0) {
      return null;
    }
    return this![index];
  }

  /// Returns a list containing only elements matching the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final evenNumbers = numbers.filterOrNewList((n) => n.isEven);
  /// print(evenNumbers); // [2, 4]
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

  /// Returns a list containing all elements not matching the given [predicate].
  ///
  /// Example:
  /// ```dart
  /// final numbers = [1, 2, 3, 4, 5];
  /// final oddNumbers = numbers.filterNot((n) => n.isEven);
  /// print(oddNumbers); // [1, 3, 5]
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

  /// Converts the list to a list of widgets using the provided [mapFunc].
  ///
  /// Example:
  /// ```dart
  /// final items = ['Apple', 'Banana', 'Cherry'];
  /// final widgets = items.toWidgetList((item) => Text(item));
  /// ```
  List<Widget> toWidgetList(Widget Function(T value) mapFunc) =>
      isNullOrEmpty ? [] : this!.map(mapFunc).toList();

  /// Returns the last index of the list, or `null` if the list is empty.
  int? get lastIndex => isNullOrEmpty ? null : this!.length - 1;

  /// Removes all occurrences of [item] from the list.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 2, 4];
  /// list.removeAll(2);
  /// print(list); // [1, 3, 4]
  /// ```
  void removeAll(T item) {
    if (isNullOrEmpty) return;
    while (this!.contains(item)) {
      this!.remove(item);
    }
  }

  /// Executes [f] for each element with its index.
  ///
  /// Example:
  /// ```dart
  /// final names = ['Alice', 'Bob', 'Charlie'];
  /// names.forEachIndexed((index, name) {
  ///   print('$index: $name');
  /// });
  /// ```
  void forEachIndexed(void Function(int index, T element) f) {
    if (isNullOrEmpty) return;
    for (var i = 0; i < this!.length; i++) {
      f(i, this![i]);
    }
  }

  /// Returns a random element from the list or `null` if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// final list = ['A', 'B', 'C', 'D'];
  /// print(list.random()); // Random element from the list
  /// ```
  T? random({int? seed}) {
    if (isNullOrEmpty) return null;
    return this![math.Random(seed).nextInt(this!.length)];
  }

  /// Inserts a [separator] after every element in the list.
  /// Optionally adds a separator at the start or end.
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3];
  /// final separatedList = list.separatorEvery(0, start: true, end: true);
  /// print(separatedList); // [0, 1, 0, 2, 0, 3, 0]
  /// ```
  List<T> separatorEvery(T separator, {bool start = false, bool end = false}) {
    List<T> list = <T>[];
    if (isNullOrEmpty) return list;

    ///First item Top separator
    if (start) {
      list.add(separator);
    }
    for (int n = 0; n < (this?.length ?? 0); n++) {
      if (end) {
        list.addAll([this![n], separator]);
        continue;
      }
      if (!end && (n == ((this?.length ?? 1) - 1))) {
        list.add(this![n]);
      }
    }
    return list;
  }

  /// Divides the list into sublists based on the given [condition].
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5, 6];
  /// final divided = list.divideListByFunction((n) => n.isEven);
  /// print(divided); // [[1], [3], [5]]
  /// ```
  List<List<T>> divideListByFunction(bool Function(T) condition) {
    List<List<T>> nestedLists = [];
    List<T> currentSublist = [];
    if (isNullOrEmpty) return [];

    for (T element in this ?? []) {
      if (condition(element)) {
        // Start a new sublist when the condition is met.
        if (currentSublist.isNotEmpty) {
          nestedLists.add(List<T>.from(currentSublist));
          currentSublist.clear();
        }
      } else {
        // Add the element to the current sublist.
        currentSublist.add(element);
      }
    }

    // Add the last sublist if it's not empty.
    if (currentSublist.isNotEmpty) {
      nestedLists.add(List<T>.from(currentSublist));
    }

    return nestedLists;
  }

  /// Splits the list into chunks of the given [rangeSize].
  ///
  /// Example:
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final chunks = list.divideListByRange(2);
  /// print(chunks); // [[1, 2], [3, 4], [5]]
  /// ```
  List<List<T>>? divideListByRange(int rangeSize) {
    if (this == null) {
      return null;
    }
    if (rangeSize <= 0) {
      throw ArgumentError('Range size must be greater than zero.');
    }

    List<List<T>> nestedLists = [];

    for (int i = 0; i < this!.length; i += rangeSize) {
      final endIndex =
          (i + rangeSize < this!.length) ? i + rangeSize : this!.length;
      nestedLists.add(this!.sublist(i, endIndex));
    }

    return nestedLists;
  }

  /// Returns the element at the specified [index], or `null` if out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final list = ['A', 'B', 'C'];
  /// print(list.tryGet(1)); // 'B'
  /// print(list.tryGet(5)); // null
  /// ```
  T? tryGet(int index) {
    if (isNullOrEmpty) {
      return null;
    }
    return (index < 0 || index >= this!.length) ? null : this![index];
  }
}

extension ListExtNotNoll<T> on List<T?>? {
  /// Maps over the list and skips null values, returning an empty list if the list itself is null
  List<R> mapNonNull<R>(R Function(T element) f) {
    // If the list is null, return an empty list
    if (this == null) return <R>[];

    // Filter out null values and apply the map function
    return this
            ?.where((e) => e != null) // Filter out null values from the list
            .map(
                (e) => f(e as T)) // Apply the map function to non-null elements
            .toList() ??
        <R>[]; // Return the result as a list
  }
}
