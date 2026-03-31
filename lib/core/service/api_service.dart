import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiService {
  static final http.Client _client = http.Client();

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'apiSecretKey': AppConfig.apiSecretKey,
  };

  // GET
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _client
        .get(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers,
    )
        .timeout(const Duration(seconds: 30));

    return _handleResponse(response);
  }

  // POST
  static Future<Map<String, dynamic>> post(
      String endpoint, {
        Map<String, dynamic>? data,
      }) async {
    final response = await _client
        .post(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(data),
    )
        .timeout(const Duration(seconds: 30));

    return _handleResponse(response);
  }

  // PUT
  static Future<Map<String, dynamic>> put(
      String endpoint, {
        Map<String, dynamic>? data,
      }) async {
    final response = await _client
        .put(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(data),
    )
        .timeout(const Duration(seconds: 30));

    return _handleResponse(response);
  }

  // DELETE
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await _client
        .delete(
      Uri.parse('${AppConfig.baseUrl}$endpoint'),
      headers: _headers,
    )
        .timeout(const Duration(seconds: 30));

    return _handleResponse(response);
  }

  // Response handler
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      );
    }
  }

  // Call this when app closes
  static void dispose() => _client.close();
}