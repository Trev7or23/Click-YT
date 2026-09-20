class YoutubeUrl {
  final String raw;

  const YoutubeUrl._(this.raw);

  factory YoutubeUrl(String url) {
    if (!isValid(url)) {
      throw const FormatException('Invalid Youtube Link');
    }
    return YoutubeUrl._(url);
  }

  static bool isValid(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    if (uri.host.contains('youtu.be')) return uri.pathSegments.isNotEmpty;
    if (uri.host.contains('youtube.com')) {
      if (uri.pathSegments.contains('shorts')) return uri.pathSegments.isNotEmpty;
      return uri.queryParameters['v'] != null;
    }
    return false;
  }

  String get videoId {
    final uri = Uri.tryParse(raw);
    if (uri == null) return raw;

    if (uri.host.contains('youtube.com')) {
      if (uri.pathSegments.contains('shorts')) return uri.pathSegments.last;
      return uri.queryParameters['v'] ?? raw;
    }

    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    }

    return raw;
  }
}