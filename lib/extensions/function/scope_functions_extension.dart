extension ScopeFunction<T> on T {
  /// Calls the specified function [op] with `this` value as its argument and returns its result.
  ///
  /// Example:
  /// ```dart
  /// int number = 5;
  /// String result = number.let((it) => 'Number is $it');
  /// print(result); // Output: Number is 5
  /// ```
  R let<R>(R Function(T it) op) => op(this);

  /// Calls the specified function [op] with `this` value as its argument and returns `this` value.
  ///
  /// Example:
  /// ```dart
  /// var person = Person('John').also((it) => it.name = 'Doe');
  /// print(person.name); // Output: Doe
  /// ```
  T also(void Function(T it) op) {
    op(this);
    return this;
  }

  /// Calls the specified function [op] with `this` value as its receiver and returns its result.
  ///
  /// Example:
  /// ```dart
  /// var result = 'Hello'.run(() => 'Hello World');
  /// print(result); // Output: Hello World
  /// ```
  R run<R>(R Function() op) => op();

  /// Calls the specified function [op] with `this` value as its receiver and returns `this` value.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3].apply(() => print('List has ${list.length} elements'));
  /// // Output: List has 3 elements
  /// ```
  T apply(void Function() op) {
    op();
    return this;
  }

  /// Returns `this` value if it satisfies the given predicate [test] or `null` if it doesn't.
  ///
  /// Example:
  /// ```dart
  /// int? number = 5.takeIf((it) => it > 3);
  /// print(number); // Output: 5
  ///
  /// number = 5.takeIf((it) => it > 6);
  /// print(number); // Output: null
  /// ```
  T? takeIf(bool Function(T it) test) => test(this) ? this : null;

  /// Returns `this` value if it does not satisfy the given predicate [test] or `null` if it does.
  ///
  /// Example:
  /// ```dart
  /// int? number = 5.takeUnless((it) => it > 6);
  /// print(number); // Output: 5
  ///
  /// number = 5.takeUnless((it) => it > 3);
  /// print(number); // Output: null
  /// ```
  T? takeUnless(bool Function(T it) test) => !test(this) ? this : null;
}
