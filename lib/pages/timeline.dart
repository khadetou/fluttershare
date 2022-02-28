import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        title: 'Timeline',
        isAppTitle: true,
      ),
      body: const Center(
        child: Text("Timeline"),
      ),
    );
  }
}
