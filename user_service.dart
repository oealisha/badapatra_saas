// user_service.dart
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  static final _storage = FlutterSecureStorage();

  static Future<http.Response> fetchUserData() async {
    final userId = await _storage.read(key: 'userid');
    final orgId = await _storage.read(key: 'orgid');

    final headers = {
      'Content-Type': 'application/json',
      'userid': userId ?? '',
      'orgid': orgId ?? '',
    };

    print("📤 Sending headers: $headers");

    final response = await http.get(
      Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
      headers: headers,
    );

    return response;
  }
}
