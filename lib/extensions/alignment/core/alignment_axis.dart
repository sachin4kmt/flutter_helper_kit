/// Vertical placement on the [-1, 1] alignment axis.
enum AlignmentVertical {
  top,
  center,
  bottom,
}

/// Horizontal placement on the [-1, 1] alignment axis.
enum AlignmentHorizontal {
  left,
  center,
  right,
}

/// Default tolerance for comparing alignment coordinates to zero.
const double kAlignmentEpsilon = 1e-10;

/// Returns `true` when [value] is effectively zero for alignment math.
bool alignmentIsNearZero(
  double value, {
  double epsilon = kAlignmentEpsilon,
}) =>
    value.abs() < epsilon;

/// Resolves [y] to a vertical axis bucket.
AlignmentVertical verticalAxisOf(
  double y, {
  double epsilon = kAlignmentEpsilon,
}) {
  if (alignmentIsNearZero(y, epsilon: epsilon)) {
    return AlignmentVertical.center;
  }
  return y < 0 ? AlignmentVertical.top : AlignmentVertical.bottom;
}

/// Resolves [x] to a horizontal axis bucket.
AlignmentHorizontal horizontalAxisOf(
  double x, {
  double epsilon = kAlignmentEpsilon,
}) {
  if (alignmentIsNearZero(x, epsilon: epsilon)) {
    return AlignmentHorizontal.center;
  }
  return x < 0 ? AlignmentHorizontal.left : AlignmentHorizontal.right;
}

/// Resolves directional [start] to a horizontal axis bucket.
AlignmentHorizontal horizontalAxisOfDirectional(
  double start, {
  double epsilon = kAlignmentEpsilon,
}) {
  if (alignmentIsNearZero(start, epsilon: epsilon)) {
    return AlignmentHorizontal.center;
  }
  return start < 0 ? AlignmentHorizontal.left : AlignmentHorizontal.right;
}
