extension MapExtensions on dynamic {
  /// Safely retrieves a value from a Map using the specified [key].
  ///
  /// Returns the value associated with the [key] if it exists in the map,
  /// otherwise returns null.
  ///
  /// Example usage:
  /// ```dart
  /// Map<String, dynamic> data = {'name': 'John Doe', 'age': 30};
  /// dynamic name = data.getIfExist('name'); // Output: 'John Doe'
  /// dynamic profession = data.getIfExist('profession'); // Output: null
  /// ```
  // @Deprecated('Deprecated on dynamic')
  // dynamic getIfExist(String key) {
  //   if(this is Map){
  //     final Map<String, dynamic> map = this;
  //     if (map.containsKey(key)) {
  //       return map[key];
  //     }
  //   }
  //   return null;
  // }
}
