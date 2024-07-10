import 'dart:math' as math;
import 'package:flutter/material.dart';

extension MyIterable<T> on Iterable<T>? {
  /// Returns `true` if this nullable iterable is either `null` or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `false` if this nullable iterable is either `null` or empty.
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  T? get firstOrNull => isNullOrEmpty ? null : this!.first;

  /// Returns the last element matching the given [predicate], or null if element was not found.
  ///  ["Flutter", "Dart", "Java", "IOS", "Android","web"].lastOrNullIf((it) => it.length == 9); // null
  ///  ["Flutter", "Dart", "Java", "IOS", "Android","web"].lastOrNullIf((it) => it.length == 3); // IOS
  T? firstWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) {
      return null;
    }
    final list = this!.where(test);
    return list.isEmpty ? null : list.first;
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

//remove first element in [list]
  List<T> get removeFirstElement {
    List<T> list = [];
    if (isNullOrEmpty) return list;
    var thisList = this!.toList();
    return thisList..removeAt(0);
  }

  //remove Last element in [list]
  List<T> get removeLastElement {
    List<T> list = [];
    if (isNullOrEmpty) return list;
    var thisList = this!.toList();
    return thisList..removeAt(thisList.length - 1);
  }

  // Returns count of elements that matches the given [predicate].
  int countWhere(bool Function(T element) predicate) {
    if (isNullOrEmpty) return 0;
    return this!.where(predicate).length;
  }

  // Returns a list containing first [n] elements.
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

  // Gets an element at specific index or returns `null`
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

  /// Returns a list containing only elements matching the given [predicate]
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

/*  /// Returns a list containing only elements matching the given [predicate]
  void filter(bool Function(T e) fun) {
    if (isNullOrEmpty) {
       return;
    }
    final result = <T>[];
    for (var element in this!) {
      if (fun(element)) this?.remove(element);
    }
  }*/

  /// Returns a list containing all elements not matching the given [predicate]
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

extension ListExt<T> on List<T>? {
  ///convert List to List of widget
  List<Widget> toWidgetList(Widget Function(T value) mapFunc) => isNullOrEmpty?[]:[...this!.map(mapFunc).toList()];

  bool get isNullOrEmpty =>
      (this == null || (this?.isEmpty ?? true)) ? true : false;

  int? get lastIndex => isNullOrEmpty ? this!.length - 1 : null;

  /// Remove all occurrences of [item] from the list.
  void removeAll(T item) {
    if (isNullOrEmpty) return;
    while (this!.contains(item)) {
      this!.remove(item);
    }
  }

  /// Counts the elements for whichs the predicate holds.
  ///
  /// See [where].
  int countWhere(bool Function(T) test) {
    if(isNullOrEmpty) return 0;
    return this!.where(test).length;
  }

  /// For each method with provides not only the element but the index as well.
  ///
  /// See [forEach].
  void forEachIndexed(void Function( int index,T element) f) {
    if(isNullOrEmpty) return;
    for (var i = 0; i < this!.length; i++) {
      f( i,this![i]);
    }
  }

  /// Return a random element of the list.
  T? random({int? seed}) {
    if(isNullOrEmpty) return null;
    return this![math.Random(seed).nextInt(this!.length)];
  }

  List<T> separatorEvery(T separator,{bool start= false,bool end=false}){
    List<T> list = <T>[];
    if(isNullOrEmpty) return list;
    ///First item Top separator
    if(start){
      list.add(separator);
    }
    for (int n = 0;n<(this?.length??0);n++) {
      if(end){
        list.addAll([this![n],separator]);
        continue;
      }
      if(!end && (n==((this?.length??1)-1))){
        list.add(this![n]);
      }
    }
    return list;
  }

  List<List<T>> divideListByFunction(bool Function(T) condition) {
    List<List<T>> nestedLists = [];
    List<T> currentSublist = [];
    if(isNullOrEmpty) return [];


    for (T element in this??[]) {
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
  List<List<T>>? divideListByRange(int rangeSize) {
    if (this == null) {
      return null;
    }
    if (rangeSize <= 0) {
      throw ArgumentError("Range size must be greater than zero.");
    }

    List<List<T>> nestedLists = [];

    for (int i = 0; i < this!.length; i += rangeSize) {
      final endIndex = (i + rangeSize < this!.length) ? i + rangeSize : this!.length;
      nestedLists.add(this!.sublist(i, endIndex));
    }

    return nestedLists;
  }

  /// Returns the element at the specified [index], or `null` if the index is out of bounds.
  T? tryGet(int index) {
    if (isNullOrEmpty) {
      return null;
    }
    return (index < 0 || index >= this!.length) ? null : this![index];
  }
}


/*
///On List Of String Extension
extension CollectionStringExtension<T extends String> on List<T> {
  String joinToString(String separator,
      {String prefix = "", String postfix = ""}) {
    return prefix + this.join(separator) + postfix;
  }
}

///On List Of num Extension
extension CollectionNumExtension<T extends num> on List<T> {
  T max() {
    if (this.isNullOrEmpty()) throw Exception("Provide collection with items");
    this.sort();
    return this[this.length - 1];
  }

  T min() {
    if (this.isNullOrEmpty()) throw Exception("Provide collection with items");
    this.sort();
    return this[0];
  }

  double avg() {
    if (this.isNullOrEmpty()) throw Exception("Provide collection with items");
    return this.reduce((value, element) => value + element) / this.length;
  }
}
 */
