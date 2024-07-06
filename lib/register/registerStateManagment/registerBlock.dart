import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms_admin/register/registerStateManagment/registerEvent.dart';
import 'package:kms_admin/register/registerStateManagment/registerState.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kms_admin/models/adminModel.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://localhost:3500/api/admin/register'));
      request.fields['email'] = event.email;
      request.fields['password'] = event.password;
      request.fields['name'] = event.name;
      request.fields['isAdmin'] = event.isAdmin.toString();

      var mimeType = MediaType('image', 'jpeg');
      request.files.add(await http.MultipartFile.fromPath(
          'img', event.fotoProfil.path,
          contentType: mimeType));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var admin = AdminModel.fromJson(data);
        emit(RegisterSuccess(admin: admin));
      } else {
        emit(RegisterFailure('Register Failed'));
      }
    } catch (e) {
      emit(RegisterFailure('Register Failed'));
    }
  }
}
