import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:fluttershare/widgets/user_result.dart';

buildSearchResult(Future<QuerySnapshot>? searchResultsFuture) {
  return FutureBuilder<QuerySnapshot>(
    future: searchResultsFuture,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return circularProgress();
      }
      List<UserResult> searchResults = [];
      for (var doc in snapshot.data!.docs) {
        User user = User.fromDocument(doc);
        UserResult searchResult = UserResult(
          user: user,
        );
        searchResults.add(searchResult);
      }
      return ListView(
        children: searchResults,
      );
    },
  );
}
