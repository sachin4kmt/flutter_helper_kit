

class RandomPicsumImage {
  /// Get a random image with specified width and height
  static String image({
    int width = 400,
    int height = 300,
    bool grayscale = false,
    int blur = 0,
  }) {
    final buffer = StringBuffer('https://picsum.photos/$width/$height');

    final params = <String>[];
    if (grayscale) params.add('grayscale');
    if (blur > 0) params.add('blur=${blur.clamp(1, 10)}');

    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }

    return buffer.toString();
  }

  /// Get an image by ID
  static String byId({
    required int id,
    int width = 400,
    int height = 300,
  }) {
    return 'https://picsum.photos/id/$id/$width/$height';
  }

  /// Get a seeded image (consistent image for a given string seed)
  static String bySeed({
    required String seed,
    int width = 400,
    int height = 300,
    bool grayscale = false,
    int blur = 0,
  }) {
    final buffer = StringBuffer('https://picsum.photos/seed/$seed/$width/$height');

    final params = <String>[];
    if (grayscale) params.add('grayscale');
    if (blur > 0) params.add('blur=${blur.clamp(1, 10)}');

    if (params.isNotEmpty) {
      buffer.write('?${params.join('&')}');
    }

    return buffer.toString();
  }

  /// Get random image info (JSON API - for custom usage)
  static String list({
    int page = 1,
    int limit = 30,
  }) {
    return 'https://picsum.photos/v2/list?page=$page&limit=$limit';
  }

  /// Get metadata for a specific image
  static String info(int id) {
    return 'https://picsum.photos/id/$id/info';
  }
}
