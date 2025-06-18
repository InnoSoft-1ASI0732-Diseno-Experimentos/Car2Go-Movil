// lib/core/services/user_seller_service.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import 'auth_service.dart';

class UserSellerService {
  final String baseUrl = ApiConstants.baseUrl;
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> createProfile(Map<String, dynamic> profileData) async {
    final url = Uri.parse('$baseUrl/profiles');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Obtener el token del AuthService
    final token = _authService.token;
    print("Token: $token");
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        print('❌ Error al crear el perfil: ${response.body}');
        return {};
      }
    } catch (e) {
      print('❌ Excepción al crear el perfil: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getMyProfile(BuildContext context) async { // Agrega BuildContext
    final profileId = _authService.profileId;

    if (profileId == null) {
      print('⚠️ No hay un perfil de usuario activo.');
      return {};
    }

    final url = Uri.parse('$baseUrl/profiles/me');
    final headers = <String, String>{}; // Inicializa headers vacío

    // Obtener el token del AuthService
    final token = _authService.token;
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 404) {
        print('⚠️ Perfil de usuario no encontrado.');
        return {};
      } else {
        print('❌ Error al obtener el perfil del usuario: ${response.body}');
        return {};
      }
    } catch (e) {
      print('❌ Excepción al obtener el perfil del usuario: $e');
      return {};
    }
  }

  Future<bool> checkIfProfileExists(BuildContext context) async {
    final url = Uri.parse('$baseUrl/profiles/me');
    final headers = <String, String>{};
    final token = _authService.token;
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        print(
            'Error al verificar el perfil: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Excepción al verificar el perfil: $e');
      return false;
    }
  }
}

