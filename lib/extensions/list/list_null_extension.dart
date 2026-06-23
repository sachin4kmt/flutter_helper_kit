extension ListNullExtension<T> on List<T>? {
  /// Returns the list if not null, otherwise returns an empty list
  List<T> validate() {
    return this ?? <T>[];
  }

  /// Returns the first element or null if list is null or empty
  T? get firstOrNull => this?.firstOrNull;

  /// Returns the last element or null if list is null or empty
  T? get lastOrNull => this?.lastOrNull;

  /// Returns true if the list is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if the list is not null and not empty
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  /// 🚀 Repeats the list items [times] number of times
  /// If list is null/empty or times <= 0, returns an empty list.
  List<T> repeat(int times) {
    if (isNullOrEmpty || times <= 0) return <T>[];

    // Iterable.generate use karke list ko expand kar rahe hain
    return List<T>.from(Iterable.generate(times, (_) => this!).expand((element) => element));
  }
}

extension LastWhereExt<T> on List<T> {
  /// The last element satisfying [test], or `null` if there are none.
  T? lastWhereOrNull(bool Function(T element) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }
}
