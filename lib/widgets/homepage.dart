import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/build_authscreen.dart';
import 'package:fluttershare/widgets/build_unauthscreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return isAuth ? const BuildAuthScreen() : const Buildunauthscreen();
  }
}
