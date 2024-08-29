import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

enum ImageSet {
  any('any'),
  set1('set1'),
  set2('set2'),
  set3('set3'),
  set4('set4'),
  set5('set5');

  final String name;

  const ImageSet(this.name);
}

enum ImageType {
  png('png'),
  gif('gif'),
  jpg('jpg'),
  bmp('bmp'),
  jpeg('jpeg'),
  ppm('ppm');

  final String name;

  const ImageType(this.name);
}

enum ImageBg {
  bg1('bg1'),
  bg2('bg2'),
  any('any');

  final String name;

  const ImageBg(this.name);
}

enum ImageColor {
  red('Red'),
  green('Green'),
  blue('Blue'),
  yellow('Yellow'),
  orange('Orange'),
  purple('Purple'),
  pink('Pink'),
  brown('Brown'),
  grey('Grey'),
  black('Black'),
  white('White');

  final String name;

  const ImageColor(this.name);
}

class RandomImage {
  /// Get a random image from Picsum with the specified dimensions.
  ///
  /// Returns a URL string pointing to a random image on Picsum with the given [width] and [height].
  ///
  /// Example:
  /// ```dart
  /// // Get a random image URL with default dimensions (200x200).
  /// String imageUrl = FlutterHelperUtils.picsumImage();
  ///
  /// // Get a random image URL with custom dimensions (300x400).
  /// String customImageUrl = FlutterHelperUtils.picsumImage(300, 400);
  /// ```
  static String picsumImage([int width = 200, int height = 200]) {
    return 'https://picsum.photos/$width/$height';
  }

  /// Generates a random image URL from robohash with the specified dimensions and category filter.
  ///
  /// The [width] and [height] parameters specify the dimensions of the image.
  /// The [category] parameter specifies the category of the image.
  ///
  /// Returns a string representing the URL of the random image.
  static String randomImage({
    String slug = 'my',
    Size size = const Size(300, 300),
    ImageSet set = ImageSet.any,
    ImageBg bg = ImageBg.any,
    ImageType imageType = ImageType.png,
    String category = 'photo',
    ImageColor? color,
  }) {
    final imageColor =
        color != null ? '&color=${color.name.toLowerCase()}' : '';
    final data =
        'https://robohash.org/$slug.${imageType.name}?size=${size.width.toInt()}x${size.height.toInt()}&set=${set.name}&bgset=${bg.name}$imageColor';
    return data;
  }

  /// Generates a random image URL from dummyimage with the specified dimensions .
  /// The [width] and [height] parameters specify the dimensions of the image.
  /// Returns a string representing the URL of the random image.
  static String dummyImage({
    String? text,
    Size size = const Size(300, 300),
    ImageType imageType = ImageType.png,
    Color bgColor = Colors.grey,
    Color fgColor = Colors.black,
  }) {
    final imageSize = '${size.width.toInt()}x${size.height.toInt()}';
    final imageText = text ?? imageSize;
    final data =
        'https://dummyimage.com/$imageSize.${imageType.name}/${bgColor.toHex(
      leadingHashSign: false,
    )}/${fgColor.toHex(leadingHashSign: false)}&text=$imageText';
    // debugPrint(data);
    return data;
  }
}
