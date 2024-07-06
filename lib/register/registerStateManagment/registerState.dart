import 'package:equatable/equatable.dart';
import 'package:kms_admin/models/adminModel.dart';

// ppp
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final AdminModel admin;

  const RegisterSuccess({
    required this.admin,
  });

  @override
  List<Object> get props => [admin];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}
