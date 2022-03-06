import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Column buildDisplayNamedField(
    {required TextEditingController displayNameController,
    required bool displayNameValid}) {
  Logger logger = Logger(printer: PrettyPrinter());
  logger.i(displayNameValid);
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
        decoration: InputDecoration(
          hintText: "Update Display Name",
          errorText: displayNameValid ? null : "Displayname too short",
        ),
      ),
    ],
  );
}
