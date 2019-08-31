import 'dart:convert';

import 'package:http/http.dart' as http;

class Parser {
  Future<http.Response> urlToResponse(dynamic url) async {
    if (url is String) {
      return http.get(url);
    }
    if (url is Map) {
      dynamic headers = url['headers'] ??
          {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36',
          };
      dynamic body = url['body'];
      // Encoding encoding =
      //     Encoding.getByName(url['encoding']?.toString() ?? 'utf8');
      if (url['method'] == null || url['method'] == 'get') {
        return http.get(url['url'], headers: headers);
      }
      if (url['method'] == 'post') {
        if (body == null) {
          return http.post(url, headers: headers);
        } else {
          return http.post(url, headers: headers, body: body);
        }
      }
    }
    return null;
  }
}
