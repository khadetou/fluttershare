import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_profile_header.dart';
import 'package:fluttershare/widgets/header.dart';
import '../models/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.profileId, required this.currentUser})
      : super(key: key);
  final String profileId;
  final User currentUser;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Container buildButton({required String text, required dynamic function}) {
    return Container(
      padding: const EdgeInsets.only(top: 2.0),
      child: TextButton(
        onPressed: function,
        child: Container(
          width: 250.0,
          height: 27.0,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(currentUserId: widget.currentUser.id),
      ),
    );
  }

  buildProfileButton() {
    bool isProfileOwner = widget.currentUser.id == widget.profileId;
    if (isProfileOwner) {
      return buildButton(
        text: "Edit Profile",
        function: editProfile,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: "Profile"),
      body: ListView(
        children: [
          buildProfileHeader(
            context,
            profileId: widget.profileId,
            buildProfileButton: buildProfileButton,
            buildCountColumn: buildCountColumn,
          )
        ],
      ),
    );
  }
}
