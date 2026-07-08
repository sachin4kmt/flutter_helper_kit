import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget mapAdapterDemo(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text(
        'CallbackMapInfoWindowAdapter lets you wire Google Maps (or any SDK) '
        'without adding map dependencies to flutter_helper_kit.',
        style: TextStyle(fontSize: 14),
      ),
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SelectableText(
            '''
final adapter = CallbackMapInfoWindowAdapter(
  onGetScreenCoordinate: (latLng) async {
    final c = await mapController.getScreenCoordinate(
      LatLng(latLng.latitude, latLng.longitude),
    );
    return MapScreenCoordinate(c.x, c.y);
  },
);
controller.mapAdapter = adapter;''',
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ),
    ],
  );
}

Widget utilsDemo(BuildContext context) {
  final ago = DateTime.now().subtract(const Duration(minutes: 5));
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      _Tile('timeAgoCalculated()', timeAgoCalculated(ago)),
      _Tile('RandomImage.picsumImage', RandomImage.picsumImage(100, 100)),
      _Tile('RandomPicsumImage.image', RandomPicsumImage.image(width: 200, height: 120)),
      ListTile(
        title: const Text('SystemUiUtils.setStatusBarColor'),
        trailing: ElevatedButton(
          onPressed: () => SystemUiUtils.setStatusBarColor(Colors.deepPurple),
          child: const Text('Apply'),
        ),
      ),
    ],
  );
}

class _Tile extends StatelessWidget {
  const _Tile(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        subtitle: Text(value, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
