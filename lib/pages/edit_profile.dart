import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_bio_field.dart';
import 'package:fluttershare/pages/homepage.dart';
import 'package:fluttershare/widgets/progress.dart';
import "package:fluttershare/functions/build_display_named_field.dart";

import '../models/user.dart';
import '../widgets/build_unauthscreen.dart';

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
  bool _displayNameValid = true;
  bool _bioValid = true;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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

  updateProfileData() {
    setState(() {
      displayNameController.text.trim().length < 3 ||
              displayNameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;

      bioController.text.trim().length > 100
          ? _bioValid = false
          : _bioValid = true;
    });
    if (_displayNameValid && _bioValid) {
      usersRef.doc(widget.currentUserId).update({
        "displayName": displayNameController.text,
        "bio": bioController.text,
      });

      SnackBar snackBar = const SnackBar(content: Text('Profile Updated!'));
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    }
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Homepage(title: "FlutterShare")));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
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
                Column(
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
                            displayNameController: displayNameController,
                            displayNameValid: _displayNameValid,
                          ),
                          buildBioField(
                            bioController: bioController,
                            bioValid: _bioValid,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: updateProfileData,
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
                        onPressed: logout,
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
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
              ]),
      ),
    );
  }
}
