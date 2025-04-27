// lib/core/models/new_vehicle.dart
class NewVehicle {
  String name = '';
  String lastName = '';
  String phone = '';
  String email = '';
  double price = 0;
  String brand = '';
  String model = '';
  String color = '';
  String year = '';
  String transmission = '';
  String engine = '';
  double mileage = 0;
  String doors = '';
  String plate = '';
  String location = '';
  String description = '';
  List<String> images = [];
  String fuel = 'Petrol'; // Default
  int speed = 0;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'brand': brand,
      'model': model,
      'color': color,
      'year': year,
      'price': price,
      'transmission': transmission,
      'engine': engine,
      'mileage': mileage,
      'doors': doors,
      'plate': plate,
      'location': location,
      'description': description,
      'images': images,
      'fuel': fuel,
      'speed': speed,
    };
  }
}
