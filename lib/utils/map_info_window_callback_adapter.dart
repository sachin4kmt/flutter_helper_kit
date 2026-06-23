import 'package:flutter/material.dart';

import 'map_custom_info_window.dart';

/// Wires [MapCustomInfoWindow] to any map SDK via callbacks (no extra dependencies).
///
/// ### With `google_maps_flutter` in your app:
/// ```dart
/// final adapter = CallbackMapInfoWindowAdapter(
///   onGetScreenCoordinate: (latLng) async {
///     final coord = await googleMapController.getScreenCoordinate(
///       LatLng(latLng.latitude, latLng.longitude),
///     );
///     return MapScreenCoordinate(coord.x, coord.y);
///   },
/// );
/// controller.mapAdapter = adapter;
/// ```
class CallbackMapInfoWindowAdapter implements MapInfoWindowAdapter {
  CallbackMapInfoWindowAdapter({
    required this.onGetScreenCoordinate,
    this.onDevicePixelRatio,
  });

  final Future<MapScreenCoordinate> Function(MapLatLng latLng) onGetScreenCoordinate;
  final double Function(BuildContext context)? onDevicePixelRatio;

  @override
  Future<MapScreenCoordinate> getScreenCoordinate(MapLatLng latLng) =>
      onGetScreenCoordinate(latLng);

  @override
  double devicePixelRatio(BuildContext context) =>
      onDevicePixelRatio?.call(context) ?? MediaQuery.of(context).devicePixelRatio;
}
