part of flutter_helper_kit;

extension ScopeFunction<T> on T {
  /// Calls the specified function block with this value as its argument and returns its result
  /// Example
  /// final list = [1,2,3,4,5,6];
  /// final list2 = list.let((it){return [...it,...it];})
  /// print(list2.toString)                                             output: [1,2,3,4,5,6,1,2,3,4,5,6]
  R let<R>(R Function(T it) op) => op(this);

  /// Calls the specified function block with this value as its argument and returns this value
  /// Example
  /// final list = [1,2,3,4,5,6].also((it){ print(it);});               output: [1,2,3,4,5,6]
  /// List list2 =list.also((it){ print([...it,...it]);});              output: [1,2,3,4,5,6,1,2,3,4,5,6]
  /// print(list2)                                                      output: [1,2,3,4,5,6]
  T also(void Function(T it) op) {
    op(this);
    return this;
  }
}
