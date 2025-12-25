import 'package:http/http.dart' as http;
import 'config.dart';

class NetworkLogger {
  static Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('➡️ POST $url');
    print('Headers: $headers');
    if (body != null) print('Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    print('⬅️ Status: ${response.statusCode}');
    print('⬅️ Response: ${response.body}');
    return response;
  }

  static Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('➡️ GET $url');
    print('Headers: $headers');

    final response = await http.get(url, headers: headers);

    print('⬅️ Status: ${response.statusCode}');
    print('⬅️ Response: ${response.body}');
    return response;
  }
}
