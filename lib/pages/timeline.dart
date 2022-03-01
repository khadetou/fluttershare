import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:logger/logger.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection("users");

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
// Varibles
  Logger logger = Logger(printer: PrettyPrinter());

  @override
  void initState() {
    super.initState();
  }

  getUsersById() async {
    const String userId = "k0dteUh8RHycOCk0kyHu";
    DocumentSnapshot doc = await usersRef.doc(userId).get();
    if (doc.exists) {
      logger.v(doc.data());
      logger.i(doc.id);
      logger.i(doc.exists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        title: 'Timeline',
        isAppTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Text> children =
              snapshot.data!.docs.map((doc) => Text(doc["username"])).toList();
          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              return children[index];
            },
          );
        },
      ),
    );
  }
}
