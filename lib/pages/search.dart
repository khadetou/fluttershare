import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/build_no_content.dart';
import 'package:fluttershare/widgets/build_search_field.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: BuildSearchField(),
      body: buildNoContent(),
    );
  }
}
