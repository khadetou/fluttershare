import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection("users");

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
// Varibles

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(
          context,
          title: 'Timeline',
          isAppTitle: true,
        ),
        body: const Center(child: Text("Timeline")));
  }
}
