import 'dart:io';

import 'package:flutter/material.dart';

/// Simple latitude/longitude pair for map overlays.
class MapLatLng {
  const MapLatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}

/// Screen coordinate returned by [MapInfoWindowAdapter.getScreenCoordinate].
class MapScreenCoordinate {
  const MapScreenCoordinate(this.x, this.y);

  final int x;
  final int y;
}

/// Adapter for map controllers (e.g. Google Maps) without package dependencies.
abstract class MapInfoWindowAdapter {
  Future<MapScreenCoordinate> getScreenCoordinate(MapLatLng latLng);

  double devicePixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;
}

/// Controller to add, update and control the custom info window.
class MapCustomInfoWindowController {
  Function(Widget, MapLatLng, double, double, double)? addInfoWindow;
  VoidCallback? onCameraMove;
  VoidCallback? hideInfoWindow;
  VoidCallback? showInfoWindow;
  MapInfoWindowAdapter? mapAdapter;

  void dispose() {
    addInfoWindow = null;
    onCameraMove = null;
    hideInfoWindow = null;
    showInfoWindow = null;
    mapAdapter = null;
  }
}

class MapCustomInfoWindow extends StatefulWidget {
  final MapCustomInfoWindowController controller;
  final void Function(double top, double left, double width, double height) onChange;

  const MapCustomInfoWindow(
    this.onChange, {
    super.key,
    required this.controller,
  });

  @override
  State<MapCustomInfoWindow> createState() => _MapCustomInfoWindowState();
}

class _MapCustomInfoWindowState extends State<MapCustomInfoWindow> {
  bool _showNow = false;
  double _leftMargin = 0;
  double _topMargin = 0;
  Widget? _child;
  MapLatLng? _latLng;
  double? _offset;
  double? _height;
  double? _width;

  @override
  void initState() {
    super.initState();
    widget.controller.addInfoWindow = _addInfoWindow;
    widget.controller.onCameraMove = _onCameraMove;
    widget.controller.hideInfoWindow = _hideInfoWindow;
    widget.controller.showInfoWindow = _showInfoWindow;
  }

  Future<void> _updateInfoWindow() async {
    final adapter = widget.controller.mapAdapter;
    if (_latLng == null ||
        _child == null ||
        _offset == null ||
        _height == null ||
        _width == null ||
        adapter == null) {
      return;
    }

    final devicePixelRatio = Platform.isAndroid
        ? adapter.devicePixelRatio(context)
        : 1.0;
    final screenCoordinate = await adapter.getScreenCoordinate(_latLng!);
    final left = (screenCoordinate.x.toDouble() / devicePixelRatio) - (_width! / 2);
    final top = (screenCoordinate.y.toDouble() / devicePixelRatio) - (_offset! + _height!);

    if (!mounted) return;
    setState(() {
      _showNow = true;
      _leftMargin = left;
      _topMargin = top;
    });
    widget.onChange(top, left, _width!, _height!);
  }

  void _addInfoWindow(
    Widget child,
    MapLatLng latLng,
    double offset,
    double height,
    double width,
  ) {
    _child = child;
    _latLng = latLng;
    _offset = offset;
    _height = height;
    _width = width;
    _updateInfoWindow();
  }

  void _onCameraMove() {
    if (!_showNow) return;
    _updateInfoWindow();
  }

  void _hideInfoWindow() {
    setState(() => _showNow = false);
  }

  void _showInfoWindow() {
    _updateInfoWindow();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _showNow &&
        !(_leftMargin == 0 && _topMargin == 0) &&
        _child != null &&
        _latLng != null;

    return Positioned(
      left: _leftMargin,
      top: _topMargin,
      child: Visibility(
        visible: visible,
        child: SizedBox(height: _height, width: _width, child: _child),
      ),
    );
  }
}
