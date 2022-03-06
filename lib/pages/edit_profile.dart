import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_bio_field.dart';
import 'package:fluttershare/pages/homepage.dart';
import 'package:fluttershare/widgets/progress.dart';
import "package:fluttershare/functions/build_display_named_field.dart";

import '../models/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    required this.currentUserId,
  }) : super(key: key);
  final String currentUserId;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() => {isLoading = true});
    DocumentSnapshot doc = await usersRef.doc(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user!.displayName;
    bioController.text = user!.bio;
    setState(() => {isLoading = false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            CachedNetworkImageProvider(user!.photoUrl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          buildDisplayNamedField(
                              displayNameController: displayNameController),
                          buildBioField(bioController: bioController),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => logger.d("Update profile data"),
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.grey[100]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton.icon(
                        onPressed: () => logger.d("loguout"),
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        label: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
    );
  }
}
