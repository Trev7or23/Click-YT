import 'package:click_yt/domain/value_objects/youtube_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YoutubeUrl.isValid', () {
    test('acepta youtube.com/watch', () {
      expect(
        YoutubeUrl.isValid('https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
        isTrue,
      );
    });

    test('acepta youtu.be', () {
      expect(YoutubeUrl.isValid('https://youtu.be/dQw4w9WgXcQ'), isTrue);
    });

    test('acepta shorts', () {
      expect(
        YoutubeUrl.isValid('https://www.youtube.com/shorts/dQw4w9WgXcQ'),
        isTrue,
      );
    });

    test('rechaza URLs de otras plataformas', () {
      expect(YoutubeUrl.isValid('https://vimeo.com/123'), isFalse);
      expect(YoutubeUrl.isValid('https://example.com'), isFalse);
    });

    test('rechaza youtube.com sin video id', () {
      expect(YoutubeUrl.isValid('https://www.youtube.com/'), isFalse);
      expect(
        YoutubeUrl.isValid('https://www.youtube.com/watch'),
        isFalse,
      );
    });

    test('rechaza youtu.be sin path', () {
      expect(YoutubeUrl.isValid('https://youtu.be/'), isFalse);
    });

    test('rechaza strings inválidas o vacías', () {
      expect(YoutubeUrl.isValid(''), isFalse);
      expect(YoutubeUrl.isValid('hola mundo'), isFalse);
    });
  });

  group('YoutubeUrl.videoId', () {
    test('extrae el id de youtube.com/watch?v=', () {
      expect(
        YoutubeUrl('https://www.youtube.com/watch?v=abc123').videoId,
        'abc123',
      );
    });

    test('extrae el id de youtu.be', () {
      expect(YoutubeUrl('https://youtu.be/abc123').videoId, 'abc123');
    });

    test('extrae el id de shorts', () {
      expect(
        YoutubeUrl('https://www.youtube.com/shorts/abc123').videoId,
        'abc123',
      );
    });
  });

  test('factory lanza FormatException en URLs inválidas', () {
    expect(() => YoutubeUrl('no es una url'), throwsFormatException);
  });
}