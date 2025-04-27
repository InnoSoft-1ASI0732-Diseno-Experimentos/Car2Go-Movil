import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import 'auth_service.dart';

class WalletService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<bool> saveWallet({required String bank, required String accountNumber}) async {
    final auth = AuthService();
    final token = auth.token;

    if (token == null) {
      print('⚠️ No hay token disponible');
      return false;
    }

    final url = Uri.parse('$baseUrl/v1/profiles/me/payment-methods/add');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'type': bank,
          'details': accountNumber,
        }),
      );

      print('🔎 Wallet Update Status: ${response.statusCode}');
      print('🔎 Wallet Update Body: ${response.body}');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('❌ Error actualizando wallet: $e');
      return false;
    }
  }
}
