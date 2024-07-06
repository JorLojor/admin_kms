import 'dart:io';
import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final String name;
  final bool isAdmin;
  final File fotoProfil;

  RegisterSubmitted({
    required this.email,
    required this.password,
    required this.name,
    required this.isAdmin,
    required this.fotoProfil,
  });

  @override
  List<Object?> get props => [email, password, name, isAdmin, fotoProfil];
}
