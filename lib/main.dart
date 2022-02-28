import 'package:flutter/material.dart';
import 'package:fluttershare/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(primarySwatch: Colors.deepPurple);
    return MaterialApp(
      title: 'Flutter Share',
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.teal),
      ),
      home: const Homepage(title: "Flutter Share"),
    );
  }
}
