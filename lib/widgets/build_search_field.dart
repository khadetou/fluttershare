import 'package:flutter/material.dart';

AppBar buildSearchField(
    {dynamic handleSearch,
    dynamic clearSearch,
    required TextEditingController searchController}) {
  return AppBar(
    backgroundColor: Colors.white,
    title: TextFormField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search for user ...",
        filled: true,
        prefixIcon: const Icon(
          Icons.account_box,
          size: 28.0,
        ),
        suffixIcon: IconButton(
          onPressed: clearSearch,
          icon: const Icon(Icons.clear),
        ),
      ),
      onFieldSubmitted: handleSearch,
    ),
  );
}
