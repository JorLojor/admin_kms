import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kms_admin/register/registerStateManagment/registerEvent.dart';
import 'package:kms_admin/register/registerStateManagment/registerState.dart';
import 'package:kms_admin/register/registerStateManagment/registerBlock.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isAdmin = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // Navigate to home or another page
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _isAdmin,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAdmin = value!;
                          });
                        },
                      ),
                      Text('Is Admin')
                    ],
                  ),
                  _imageFile == null
                      ? Text('No image selected.')
                      : Image.file(_imageFile!),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pick Image'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_imageFile != null) {
                        BlocProvider.of<RegisterBloc>(context).add(
                          RegisterSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text,
                            name: _nameController.text,
                            isAdmin: _isAdmin,
                            fotoProfil: _imageFile!,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select an image')));
                      }
                    },
                    child: state is RegisterLoading
                        ? CircularProgressIndicator()
                        : Text('Register'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
