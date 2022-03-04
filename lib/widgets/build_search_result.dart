import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:logger/logger.dart';

buildSearchResult(Future<QuerySnapshot>? searchResultsFuture) {
  Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  return FutureBuilder<QuerySnapshot>(
    future: searchResultsFuture,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return circurlarProgress();
      }
      List<Text> searchResults = [];
      for (var doc in snapshot.data!.docs) {
        User user = User.fromDocument(doc);
        searchResults.add(Text(user.username));
      }
      return ListView(
        children: searchResults,
      );
    },
  );
}
