import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kms_admin/introPage.dart';
import 'package:kms_admin/register/registerPage.dart';
import 'package:kms_admin/register/registerStateManagment/registerBlock.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
