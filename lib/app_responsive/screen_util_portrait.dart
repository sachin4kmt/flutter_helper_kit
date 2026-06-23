part of 'app_responsive.dart';



extension ScreenUtilPortrait on ScreenUtil {
  /// Portrait width scaled according to design size
  double get portraitWidth {
    // Portrait mode में full width
    if (_orientation == Orientation.portrait) {
      return screenWidth;
    }
    // Landscape में fallback: portrait width
    return min(screenWidth, screenHeight);
  }

  /// Portrait height scaled according to design size
  double get portraitHeight {
    if (_orientation == Orientation.portrait) {
      return screenHeight;
    }
    // Landscape में fallback: portrait height
    return max(screenWidth, screenHeight);
  }

  /// Portrait width scaled according to design size using ScreenUtil scale
  double portraitSetWidth(num width) {
    // Portrait mode में width scale
    if (_orientation == Orientation.portrait) {
      return setWidth(width);
    }
    // Landscape में fallback: use portrait width scale
    return setWidth(width);
  }

  /// Portrait height scaled according to design size using ScreenUtil scale
  double portraitSetHeight(num height) {
    if (_orientation == Orientation.portrait) {
      return setHeight(height);
    }
    return setHeight(height);
  }
}

