part of 'generic_dropdown_sheet.dart';

abstract class DropdownItem<T> {
  String getLabel();

  T getValue();
}

class MyDropdownItem extends DropdownItem<String> {
  final String label;
  final String value;

  MyDropdownItem({required this.label, required this.value});

  @override
  String getLabel() {
    return label;
  }

  @override
  String getValue() {
    return value;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDropdownItem &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
