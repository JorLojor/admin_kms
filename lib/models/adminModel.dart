import 'package:equatable/equatable.dart';

class AdminModel extends Equatable {
  final String id;
  final String email;
  final String password;
  final String name;
  final bool isAdmin;
  final String fotoProfil;

  AdminModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.isAdmin,
    required this.fotoProfil,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      isAdmin: json['isAdmin'],
      fotoProfil: json['fotoProfil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'name': name,
      'isAdmin': isAdmin,
      'fotoProfil': fotoProfil,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        password,
        name,
        isAdmin,
        fotoProfil,
      ];
}
