import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/timeline.dart';
import 'package:fluttershare/functions/build_no_content.dart';
import 'package:fluttershare/functions/build_search_field.dart';
import 'package:fluttershare/functions/build_search_result.dart';
import 'package:logger/logger.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  Future<QuerySnapshot>? searchResultsFuture;
  Logger logger = Logger(printer: PrettyPrinter());

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        usersRef.where("displayName", isGreaterThanOrEqualTo: query).get();

    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(
        handleSearch: handleSearch,
        clearSearch: clearSearch,
        searchController: searchController,
      ),
      body: searchResultsFuture == null
          ? buildNoContent(context)
          : buildSearchResult(searchResultsFuture),
    );
  }
}
