import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class AuthService {
  final String baseUrl = ApiConstants.baseUrl;

  String? _token; // Private token variable
  String? username;
  int? profileId;

  // Private constructor
  AuthService._privateConstructor();

  // Static instance
  static final AuthService _instance = AuthService._privateConstructor();

  // Factory constructor to return the static instance
  factory AuthService() {
    return _instance;
  }

  String? get token => _token; // Public getter for the token

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/authentication/sign-in');
    print('Enviando login a $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token']; // Use the private variable
      this.username = data['username'];
      profileId = data['id'];
      print('✅ Login exitoso. Token: $_token, Usuario: ${this.username}, ID: $profileId');
      return true;
    } else {
      print('❌ Error en login: ${response.body}');
      return false;
    }
  }

  Future<bool> register(String username, String password, List<String> roles) async {
    final url = Uri.parse('$baseUrl/authentication/sign-up');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'roles': roles,
      }),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    return response.statusCode == 201 || response.statusCode == 200;
  }
}
    