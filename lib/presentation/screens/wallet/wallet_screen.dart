import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/wallet_service.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _bankController = TextEditingController();
  final _accountNumberController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadWalletData();
  }

  void _loadWalletData() {
    // Aquí podrías cargar datos reales si tienes un servicio
    setState(() {
      _bankController.text = '';
      _accountNumberController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF282828),
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100,
        title: Image.asset('assets/logo-car.png', height: 56),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.account_circle, size: 52, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            const Text(
              'MY ',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              'WALLET',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFD54F)),
            ),
            const SizedBox(height: 32),
            _buildInputField('Bank', _bankController),
            const SizedBox(height: 16),
            _buildInputField('Account Number / CCI', _accountNumberController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isEditing ? _saveWallet : _enableEditing,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD54F),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: Text(
                _isEditing ? 'SAVE WALLET' : 'EDIT WALLET',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    final showText = controller.text.isNotEmpty ? controller.text : 'Not define';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: _isEditing,
          readOnly: !_isEditing,
          style: TextStyle(
            color: controller.text.isNotEmpty ? Colors.black : Colors.grey,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F3F3),
            hintText: showText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  void _enableEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveWallet() async {
    try {
      final success = await WalletService().saveWallet(
        bank: _bankController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Wallet updated successfully')),
        );
        setState(() {
          _isEditing = false; // Vuelve a modo solo lectura
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ Profile not found, saving locally...')),
        );
        print('🏦 Bank: ${_bankController.text}');
        print('🏦 Account Number: ${_accountNumberController.text}');
        setState(() {
          _isEditing = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Error updating wallet')),
      );
    }
  }


}
