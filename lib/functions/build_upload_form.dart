import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/widgets/progress.dart';

Scaffold buildUploadForm(
  context,
  dynamic clearImage,
  dynamic handleSubmit,
  dynamic getUserLocation,
  File file,
  User? currentUser,
  bool isUploading,
  TextEditingController captionController,
  TextEditingController locationController,
) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white70,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: clearImage,
      ),
      title: const Text(
        "Caption Post",
        style: TextStyle(color: Colors.black26),
      ),
      actions: [
        TextButton(
          onPressed: isUploading ? null : () => handleSubmit(),
          child: const Text(
            "Post",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    ),
    body: ListView(
      children: <Widget>[
        isUploading ? linearProgress() : const Text(""),
        SizedBox(
          height: 220.0,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(file),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              currentUser!.photoUrl,
            ),
          ),
          title: SizedBox(
            width: 250.0,
            child: TextField(
              controller: captionController,
              decoration: const InputDecoration(
                hintText: "Write a caption...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.pin_drop,
            color: Colors.orange,
            size: 35.0,
          ),
          title: SizedBox(
            width: 250.0,
            child: TextField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: "Where was this photo taken ?",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          width: 200.0,
          height: 100.0,
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: getUserLocation, //getUserLocation()
            icon: const Icon(
              Icons.my_location,
              color: Colors.white,
            ),
            label: const Text(
              "Use Current Location",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}
