import 'package:flutter/material.dart';

class BuildAuthScreen extends StatelessWidget {
  const BuildAuthScreen({Key? key, required this.logout}) : super(key: key);

  final dynamic logout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auth'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: logout,
            child: const Text('Logout'),
          ),
        ));
  }
}
