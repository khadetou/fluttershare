import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: "Debug"),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
            Navigator.pop(context),
          },
          child: const Text("Debug"),
        ),
      ),
    );
  }
}
