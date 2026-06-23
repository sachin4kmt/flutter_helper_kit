import 'package:flutter/material.dart';

extension RowExtension on Row {
  /// Wrap Row with IntrinsicHeight
  Widget intrinsicHeight() => IntrinsicHeight(child: this);
}