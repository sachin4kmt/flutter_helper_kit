part of flutter_helper_kit;

extension ListWidgetExtension on List<Widget> {
  List<Widget> get expandEvery =>
      map((Widget e) => Expanded(child: e)).toList();

  List<Widget> get flexibleEvery =>
      map((Widget e) => Flexible(child: e)).toList();

  List<Widget> get spacerEvery {
    List<Widget> list = <Widget>[];
    this.forEachIndexed((index,element) {
      index == (length - 1)
          ? list.add(this[index])
          : list.addAll([this[index], const Spacer()]);
    });
    return list;
  }
}


extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() =>
      map((widget) => Expanded(flex: 1, child: widget));

}
