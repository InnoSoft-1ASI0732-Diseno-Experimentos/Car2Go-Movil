// lib/core/services/vehicle_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import 'auth_service.dart'; // importa el AuthService

class VehicleService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<Map<String, dynamic>>> getVehiclesByProfile(String profileId) async {
    final url = Uri.parse('$baseUrl/v1/vehicle/all/vehicles/profile/$profileId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((vehicle) => vehicle as Map<String, dynamic>).toList();
      } else {
        print('❌ Error al obtener vehículos: ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Excepción al obtener vehículos: $e');
      return [];
    }
  }

  // Este nuevo método usa el profileId directamente del AuthService
  Future<List<Map<String, dynamic>>> getMyCars() async {
    final auth = AuthService();
    final profileId = auth.profileId;

    if (profileId == null) {
      print('⚠️ No hay perfil activo');
      return [];
    }

    return await getVehiclesByProfile(profileId.toString());
  }

  Future<List<Map<String, dynamic>>> getAllVehicles() async {
    final url = Uri.parse('$baseUrl/vehicle/all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((vehicle) => vehicle as Map<String, dynamic>).toList();
      } else {
        print('❌ Error al obtener todos los vehículos: ${response.body}');
        return [];
      }
    } catch (e) {
      print('❌ Excepción al obtener todos los vehículos: $e');
      return [];
    }
  }
}
