import 'package:flutter/material.dart';
import 'package:car_2_go/core/services/profile_service.dart';
import 'package:car_2_go/presentation/screens/wallet/wallet_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _imageController = TextEditingController(); // 👈 Añadido para la URL de imagen
  final _dniController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isEditing = false; // 👈 controlar edición

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    setState(() {
      _firstNameController.text = 'Cesar Antonio';
      _lastNameController.text = 'Castilla Pachas';
      _emailController.text = 'test@email.com';
      _imageController.text = ''; // ← URL de imagen aún vacía
      _dniController.text = '';
      _addressController.text = '';
      _phoneController.text = '';
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
              'PROFILE',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFD54F)),
            ),
            const SizedBox(height: 32),

            // Mostramos imagen si tiene url
            _buildProfileImage(),

            const SizedBox(height: 32),
            _buildInputField('Name', _firstNameController),
            const SizedBox(height: 16),
            _buildInputField('Last Name', _lastNameController),
            const SizedBox(height: 16),
            _buildInputField('Email', _emailController),
            const SizedBox(height: 16),
            _buildInputField('Image URL', _imageController), // 👈 Nuevo campo
            const SizedBox(height: 16),
            _buildInputField('Identity Document (DNI)', _dniController),
            const SizedBox(height: 16),
            _buildInputField('Address', _addressController),
            const SizedBox(height: 16),
            _buildInputField('Phone', _phoneController),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isEditing ? _saveProfile : _enableEditing,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: Text(
                    _isEditing ? 'SAVE CHANGES' : 'EDIT PROFILE',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: _openWallet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD54F),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text('WALLET', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_imageController.text.isEmpty) {
      return const Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFFF3F3F3),
          child: Icon(Icons.person, size: 50, color: Colors.grey),
        ),
      );
    }

    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(_imageController.text),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    final showText = controller.text.isNotEmpty ? controller.text : 'No especificado';

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

  void _saveProfile() async {
    final success = await ProfileService().saveProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      image: _imageController.text.trim(), // 👈 también guardamos la imagen
      dni: _dniController.text.trim(),
      address: _addressController.text.trim(),
      phone: _phoneController.text.trim(),
    );


    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Profile updated successfully')),
      );
      setState(() {
        _isEditing = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to update profile')),
      );
    }
  }

  void _openWallet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WalletScreen()),
    );
  }
}
