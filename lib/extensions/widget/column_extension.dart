import 'package:material_ui/material_ui.dart';

extension ColumnExtension on Column {
  /// Wrap Column with IntrinsicWidth
  Widget intrinsicWidth() => IntrinsicWidth(child: this);
}
