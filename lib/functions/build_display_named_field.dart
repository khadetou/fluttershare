import 'package:flutter/material.dart';

Column buildDisplayNamedField(
    {required TextEditingController displayNameController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Text(
          "Display Name",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      TextField(
        controller: displayNameController,
        decoration: const InputDecoration(
          hintText: "Update Display Name",
        ),
      ),
    ],
  );
}
