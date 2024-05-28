import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<http.Response> get(url) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
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