// lib/core/services/profile_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import 'auth_service.dart';

class ProfileService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<bool> saveProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String image,
    required String dni,
    required String address,
    required String phone,
  }) async {
    final token = AuthService().token; // si quieres usar autenticación
    if (token == null) {
      print('⚠️ No hay token disponible');
      return false;
    }

    final url = Uri.parse('$baseUrl/v1/profiles');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'image': image,
          'dni': dni,
          'address': address,
          'phone': phone,
        }),
      );

      print('🔎 Status save profile: ${response.statusCode}');
      print('🔎 Body save profile: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('❌ Error al guardar perfil: $e');
      return false;
    }
  }
}
