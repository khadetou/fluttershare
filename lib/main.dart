import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/create_account.dart';
import 'package:fluttershare/pages/homepage.dart';
import 'package:logger/logger.dart';
import "./firebase_options.dart";

final Logger logger = Logger(printer: PrettyPrinter());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
