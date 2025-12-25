// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import './api_service.dart';

// class ApiService {
//   static Future<List<Service>> fetchWaraBadapatra() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userid = prefs.getString('userid') ?? '';
//       final orgid = prefs.getString('orgid') ?? '';
//       final orgCode = prefs.getString('org_code') ?? '';

//       print('Sending Headers: userid=$userid, orgid=$orgid, org_code=$orgCode');

//       final response = await http.post(
//         Uri.parse('http://digitalbadapatra.com/api/v1/get_wara_badapatra'),
//         headers: {'userid': userid, 'orgid': orgid, 'org_code': orgCode},
//       );

//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);

//         if (decoded is! List) {
//           throw Exception('API response is not a valid list');
//         }

//         return decoded.map<Service>((json) => Service.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load service: HTTP ${response.statusCode}');
//       }
//     } catch (e) {
//       print('EXCEPTION: $e');
//       throw Exception('Failed to load service: $e');
//     }
//   }
// }

// api_service.dart

// import 'dart:convert';
// import 'package:flutter/foundation.dart'; // for kIsWeb
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'config.dart'; // make sure this has: const String baseUrl = "https://sprta.digitalbadapatra.com/api/v1";
// import './network_logger.dart';

// class ApiService {
//   /// Fetch Wara Badapatra data
//   static Future<List<Service>> fetchWaraBadapatra() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final userid = prefs.getString('userid') ?? '';
//       final orgid = prefs.getString('orgid') ?? '';
//       final orgCode = prefs.getString('org_code') ?? '';

//       print('Headers: userid=$userid, orgid=$orgid, org_code=$orgCode');

//       // Determine the URL for Web vs Mobile
//       Uri url;
//       if (kIsWeb) {
//         // Use CORS proxy for Web
//         url = Uri.parse(
//           'https://cors-anywhere.herokuapp.com/$baseUrl/get_wara_badapatra',
//         );
//       } else {
//         url = Uri.parse('$baseUrl/get_wara_badapatra');
//       }

//       print('Calling API: $url');

//       final response = await http.post(
//         url,
//         headers: {'userid': userid, 'orgid': orgid, 'org_code': orgCode},
//       );

//       print('Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final decoded = jsonDecode(response.body);

//         if (decoded is! List) {
//           throw Exception('API response is not a valid list');
//         }

//         return decoded.map<Service>((json) => Service.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load service: HTTP ${response.statusCode}');
//       }
//     } catch (e) {
//       print('EXCEPTION: $e');
//       throw Exception('Failed to load service: $e');
//     }
//   }
// }

// // Example Service model
// class Service {
//   final String name;
//   final String id;

//   Service({required this.name, required this.id});

//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(name: json['name'] ?? '', id: json['id'] ?? '');
//   }
// }

//RAMPUR:
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://digitalbadapatra.com/api/v1";

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> _token() async {
    return _storage.read(key: "token");
  }

  static Future<Map<String, String>> _headers() async {
    final token = await _token();
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: await _headers(),
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error ${response.statusCode}: ${response.body}");
    }
  }
}
