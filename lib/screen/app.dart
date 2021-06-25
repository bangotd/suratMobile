import 'package:flutter/material.dart';
import 'package:tutorial_app/screen/register.dart';


class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Registrasi Bangotd',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form+ Registrasi'),
        ),
        // body: RegisterScreen(),
      ),
    );
  }
}