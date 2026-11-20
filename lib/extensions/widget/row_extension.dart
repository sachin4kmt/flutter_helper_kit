import 'package:material_ui/material_ui.dart';

extension RowExtension on Row {
  /// Wrap Row with IntrinsicHeight
  Widget intrinsicHeight() => IntrinsicHeight(child: this);
}
