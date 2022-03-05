import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_splash_screen.dart';
import 'package:fluttershare/functions/build_upload_form.dart';
import 'package:fluttershare/models/user.dart';
import 'package:image_picker/image_picker.dart';
import "package:image/image.dart" as image;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final storageRef = FirebaseStorage.instance.ref();
final postRef = FirebaseFirestore.instance.collection('posts');

class Upload extends StatefulWidget {
  const Upload({
    Key? key,
    this.currentUser,
  }) : super(key: key);
  final User? currentUser;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  XFile? _file;
  late File file;
  bool isUploading = false;
  String postId = const Uuid().v4();

  Logger logger = Logger(printer: PrettyPrinter());

  handlePhoto() async {
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675.0,
      maxWidth: 960.0,
    );
    setState(() {
      _file = photo;
      file = File(photo!.path);
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = image;
      file = File(image!.path);
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: const Text("Photo with camera"),
                onPressed: handlePhoto,
              ),
              SimpleDialogOption(
                child: const Text("Image from gallery"),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  clearImage() {
    setState(() {
      _file = null;
      file = File(_file!.path);
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    image.Image? imageFile = image.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(image.encodeJpg(imageFile!, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    UploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    TaskSnapshot storageSnapshot = await uploadTask;
    String downloadUrl = await storageSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore({
    required String mediaUrl,
    required String location,
    required String description,
  }) {
    postRef
        .doc(widget.currentUser!.id)
        .collection("userPosts")
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": widget.currentUser!.id,
      "username": widget.currentUser!.username,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": FieldValue.serverTimestamp(),
      "likes": {},
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();

    String mediaUrl = await uploadImage(file);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    setState(() {
      _file = null;
      isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? buildSplashScreen(context, selectImage)
        : buildUploadForm(
            context,
            clearImage,
            handleSubmit,
            file,
            widget.currentUser,
            isUploading,
            captionController,
            locationController,
          );
  }
}
