import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/pages/homepage.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:logger/logger.dart';

import '../../../models/user.dart';

buildPostHeader({required ownerId, required location}) {
  Logger logger = Logger(printer: PrettyPrinter());
  return FutureBuilder<DocumentSnapshot>(
    future: usersRef.doc(ownerId).get(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return circularProgress();
      }
      User user = User.fromDocument(snapshot.data!);
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(user.photoUrl),
          backgroundColor: Colors.grey,
        ),
        title: GestureDetector(
          child: Text(
            user.username,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(location),
        trailing: IconButton(
          onPressed: () => logger.i("Deleting post"),
          icon: const Icon(Icons.more_vert),
        ),
      );
    },
  );
}
