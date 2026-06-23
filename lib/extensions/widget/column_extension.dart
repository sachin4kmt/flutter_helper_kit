

import 'package:flutter/material.dart';

extension ColumnExtension on Column {
  /// Wrap Column with IntrinsicWidth
  Widget intrinsicWidth() => IntrinsicWidth(child: this);
}