import 'package:http/http.dart' as http;

class Parser {
  Future<http.Response> urlParser(dynamic url) async {
    if (url is String) {
      return http.get(url);
    }
    if (url is Map) {
      url = (url as Map).map((k, v) => MapEntry(k.toString().toLowerCase(), v));

      Map<String, String> headers = {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36',
      }..addAll(Map<String, String>.from(url['headers'] ?? Map()));

      dynamic body = url['body'];
      dynamic method = url['method']?.toString()?.toLowerCase();

      if (method == null || method == 'get') {
        return http.get(url['url'], headers: headers);
      }
      if (method == 'post') {
        return body == null
            ? http.post(url['url'], headers: headers)
            : http.post(url['url'], headers: headers, body: body);
      }
    }
    throw ('error parser url rule');
  }
}
