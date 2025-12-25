import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import './homepage_api.dart';

class HomePageApi {
  static const String _url =
      'http://digitalbadapatra.com/api/v1/get_wara_badapatra';
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Fetch Wara Badapatra data from API
  static Future<Map<String, dynamic>?> fetchWaraBadapatra() async {
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        print('Token not found. User might not be logged in.');
        return null;
      }

      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}), // send empty body or required data if needed
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching Wara Badapatra: $e');
      return null;
    }
  }
}
