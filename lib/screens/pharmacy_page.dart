import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PharmacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Sayfa"),
      ),
      body: Center(
        child: Text("Bu yeni bir sayfa!"),
      ),
    );
  }
}