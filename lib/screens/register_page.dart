import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: const Text('Kayıt Ol'),
      ),
      body: const Center(
        child: Text('Kayıt Sayfası'),
      ),
    );
  }
}
