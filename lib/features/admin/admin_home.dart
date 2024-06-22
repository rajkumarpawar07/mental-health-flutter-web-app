import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: const Center(
        child: Text('Admin Home'),
      ),
    );
  }
}
