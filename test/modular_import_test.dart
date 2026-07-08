import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_extensions.dart';
import 'package:flutter_helper_kit/flutter_helper_kit_utils.dart';

void main() {
  group('Modular imports', () {
    test('extensions barrel exports string case', () {
      expect('hello_world'.toTitleCase(), 'Hello World');
    });

    test('utils barrel exports callback adapter', () {
      final adapter = CallbackMapInfoWindowAdapter(
        onGetScreenCoordinate: (_) async => const MapScreenCoordinate(0, 0),
      );
      expect(adapter, isA<MapInfoWindowAdapter>());
    });
  });
}
