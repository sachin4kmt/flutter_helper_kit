part of 'app_responsive.dart';

extension ScreenUtilPortrait on ScreenUtil {
  double get portraitWidth {
    if (_orientation == Orientation.portrait) {
      return screenWidth;
    }
    return min(screenWidth, screenHeight);
  }

  double get portraitHeight {
    if (_orientation == Orientation.portrait) {
      return screenHeight;
    }
    return max(screenWidth, screenHeight);
  }

  double portraitSetWidth(num width) {
    if (_orientation == Orientation.portrait) {
      return setWidth(width);
    }
    final portraitScale = portraitWidth / _uiSize.width;
    return width * portraitScale;
  }

  double portraitSetHeight(num height) {
    if (_orientation == Orientation.portrait) {
      return setHeight(height);
    }
    final portraitScale = portraitHeight / _uiSize.height;
    return height * portraitScale;
  }
}
