import 'package:flutter/material.dart';

Column buildBioField(
    {required TextEditingController bioController, required bool bioValid}) {
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
        decoration: InputDecoration(
          hintText: "Update Bio",
          errorText: bioValid ? null : "Bio too long",
        ),
      ),
    ],
  );
}
