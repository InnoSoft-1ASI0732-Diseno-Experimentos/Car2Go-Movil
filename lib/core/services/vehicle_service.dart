// lib/core/services/vehicle_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import 'auth_service.dart';
import '/models/new_vehicle.dart';

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

  Future<List<Map<String, dynamic>>> getMyCars() async {
    final auth = AuthService(); // 👈 CARGAR la instancia aquí en tiempo real
    final profileId = auth.profileId;

    if (profileId == null) {
      print('⚠️ No hay perfil activo');
      return [];
    }

    return await getVehiclesByProfile(profileId.toString());
  }

  Future<bool> createVehicle(NewVehicle newVehicle) async {
    final auth = AuthService(); // 👈 TAMBIÉN AQUÍ cargar en tiempo real
    final profileId = auth.profileId;
    final token = auth.token;

    if (profileId == null || token == null) {
      print('⚠️ No hay perfil activo o token');
      return false;
    }

    final url = Uri.parse('$baseUrl/v1/vehicle');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // usar el token que ya estaba cargado en memoria
        },
        body: jsonEncode({
          'name': newVehicle.name,
          'phone': newVehicle.phone,
          'email': newVehicle.email,
          'brand': newVehicle.brand,
          'model': newVehicle.model,
          'color': newVehicle.color,
          'year': newVehicle.year,
          'price': newVehicle.price,
          'transmission': newVehicle.transmission,
          'engine': newVehicle.engine,
          'mileage': newVehicle.mileage,
          'doors': newVehicle.doors,
          'plate': newVehicle.plate,
          'location': newVehicle.location,
          'description': newVehicle.description,
          'images': newVehicle.images,
          'fuel': newVehicle.fuel,
          'speed': newVehicle.speed
        }),
      );

      print('📋 Header enviado: Bearer $token');
      print('🔎 Response status: ${response.statusCode}');
      print('🔎 Response body: ${response.body}');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('❌ Error al crear vehículo: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAllVehicles() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/v1/vehicle/all');

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
