import 'package:flutter/material.dart';

class BuildAuthScreen extends StatelessWidget {
  const BuildAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body:const Center(
        child: Text('Auth'),
      )
    );
  }
}
