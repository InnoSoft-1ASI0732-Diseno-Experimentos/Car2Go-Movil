import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal(); // 👈 Crea una sola instancia
  factory AuthService() => _instance; // 👈 Siempre devuelve la misma instancia
  AuthService._internal();

  final String baseUrl = ApiConstants.baseUrl;

  String? token;
  String? username;
  int? profileId;

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/v1/authentication/sign-in');
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

      token = data['token'];
      this.username = data['username'];
      profileId = data['id'];

      print('✅ Login exitoso. Token: $token, Usuario: ${this.username}, ID: $profileId');
      return true;
    } else {
      print('❌ Error en login: ${response.body}');
      return false;
    }
  }

  Future<bool> register(String username, String password, List<String> roles) async {
    final url = Uri.parse('$baseUrl/v1/authentication/sign-up');

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
