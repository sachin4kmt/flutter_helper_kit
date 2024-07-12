extension ListnumManipulation on List<num>? {
  /// check nullable and empty in nullable list return true
  bool get isNullAndEmpty => this == null && this!.isEmpty;

  /// check not nullable and not empty in nullable list return true
  bool get isNotNullAndEmpty => this != null && this!.isNotEmpty;

  /// Get total from list of num
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
