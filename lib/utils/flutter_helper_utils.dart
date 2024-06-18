import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class FlutterHelperUtils {
  /// Converts degrees to radians.
  /// Returns the equivalent value in radians for the given [degree].
  ///
  ///  Convert degrees to radians
  ///   double radian = SachinUtils.degreeToRadian(degree);
  ///   print('45 degrees in radians: $radian'); // Output: 0.7853981633974483
  static double degreeToRadian(double degree) {
    return degree * (-math.pi / 180);
  }

  /// Short for [Future.delayed].
  ///
  /// Delays the execution by [millisecond] milliseconds and returns [value]
  /// after the delay. If [value] is not provided, returns `null`.
  ///
  /// Example:
  /// ```dart
  /// // Delay execution for 1 second.
  /// await SachinUtils.wait(1000);
  ///
  /// // Delay execution for 500 milliseconds and return a value.
  /// String result = await SachinUtils.wait<String>(500, () {
  ///   return 'Delayed value';
  /// });
  /// ```
  static Future<T> wait<T>([
    int millisecond = 1500,
    FutureOr<T> Function()? value,
  ]) async {
    await Future.delayed(Duration(milliseconds: millisecond));
    return value == null ? null as T : value.call();
  }

  /// Checks the network connection by attempting to lookup 'google.com'.
  ///
  /// Returns `true` if the device is connected to the internet,
  /// otherwise returns `false`.
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Loads bytes from the specified asset path.
  ///
  /// Returns a [Future] containing a [Uint8List] representing the bytes of the asset.
  ///
  /// The [path] parameter is the path to the asset.
  ///
  /// The [width] parameter specifies the target width for resizing the image.
  ///
  /// Example usage:
  /// ```dart
  /// Future<Uint8List> bytes = SachinUtils.getBytesFromAsset('assets/marker.png', width: 100);
    static Future<Uint8List> getBytesFromAsset(String path, {int? width}) async {
    ByteData data = await rootBundle.load(path);
    if (width == null) {
      return data.buffer.asUint8List();
    }
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );

    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


}

