extension ListnumManipulation on List<num>? {
  /// Returns `true` if the list is either `null` or empty.
  ///
  /// Example:
  /// ```dart
  /// List<num>? list1 = null;
  /// print(list1.isNullAndEmpty); // true
  ///
  /// List<num>? list2 = [];
  /// print(list2.isNullAndEmpty); // true
  ///
  /// List<num>? list3 = [1, 2, 3];
  /// print(list3.isNullAndEmpty); // false
  /// ```
  bool get isNullAndEmpty => this == null && this!.isEmpty;

  /// Returns `true` if the list is not `null` and contains at least one element.
  ///
  /// Example:
  /// ```dart
  /// List<num>? list1 = [1, 2, 3];
  /// print(list1.isNotNullAndEmpty); // true
  ///
  /// List<num>? list2 = [];
  /// print(list2.isNotNullAndEmpty); // false
  ///
  /// List<num>? list3 = null;
  /// print(list3.isNotNullAndEmpty); // false
  /// ```
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  /// Returns the sum of all elements in the list.
  /// If the list is `null` or empty, it returns `0`.
  ///
  /// Example:
  /// ```dart
  /// List<num>? numbers = [1, 2, 3, 4, 5];
  /// print(numbers.total); // 15
  ///
  /// List<num>? emptyList = [];
  /// print(emptyList.total); // 0
  ///
  /// List<num>? nullList = null;
  /// print(nullList.total); // 0
  /// ```
  num get total {
    num t = 0;
    if (isNotNullAndEmpty) {
      for (var e in (this ?? [])) {
        t += e;
      }
    }
    return t;
  }
}
