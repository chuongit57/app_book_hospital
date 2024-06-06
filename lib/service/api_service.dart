import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<http.Response> get(url) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    return response;
  }

  static Future<http.Response> getToken(url) async {
    const secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    return response;
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> postToken(String url, Map<String, dynamic> body) async {
    const secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  static Future<http.Response> delete(String url) async {
    final response = await http.delete(
      Uri.parse(url),
    );
    return response;
  }
}