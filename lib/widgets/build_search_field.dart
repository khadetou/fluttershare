import 'package:flutter/material.dart';

AppBar BuildSearchField() {
  return AppBar(
    backgroundColor: Colors.white,
    title: TextFormField(
      decoration: const InputDecoration(
        hintText: "Search for user ...",
        filled: true,
        prefixIcon: Icon(
          Icons.account_box,
          size: 28.0,
        ),
        suffixIcon: IconButton(
          onPressed: null,
          icon: Icon(Icons.clear),
        ),
      ),
    ),
  );
}
