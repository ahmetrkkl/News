import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: const Text('Giriş Yap'),
      ),
      body: const Center(
        child: Text('Giriş Sayfası'),
      ),
    );
  }
}
