import 'package:flutter/material.dart';

Column buildBioField({required TextEditingController bioController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: Text(
          "Display Bio",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      TextField(
        controller: bioController,
        decoration: const InputDecoration(
          hintText: "Update Bio",
        ),
      ),
    ],
  );
}
