import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_profile_header.dart';
import 'package:fluttershare/functions/profile/build_toggle_post_orientation.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:logger/logger.dart';
import '../functions/profile/build_profile_posts.dart';
import '../models/user.dart';
import '../widgets/post.dart';
import 'edit_profile.dart';
import "package:fluttershare/pages/homepage.dart";

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.profileId, required this.currentUser})
      : super(key: key);
  final String profileId;
  final User currentUser;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String postOrientation = "grid";
  bool isLoading = false;
  int postCount = 0;
  List<Post> posts = [];

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
          width: MediaQuery.of(context).size.width * 0.63,
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
  void initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postRef
        .doc(widget.profileId)
        .collection('userPosts')
        .orderBy("timestamp", descending: true)
        .get();

    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
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
            postCount: postCount,
          ),
          const Divider(),
          buildTogglePostOrientation(
            context,
            setPostOrientation: setPostOrientation,
            postOrientation: postOrientation,
          ),
          const Divider(
            height: 0.0,
          ),
          buildProfilePosts(
            isLoading: isLoading,
            posts: posts,
            postOrientation: postOrientation,
          ),
        ],
      ),
    );
  }
}
