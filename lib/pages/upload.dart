import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttershare/functions/build_splash_screen.dart';
import 'package:fluttershare/functions/build_upload_form.dart';
import 'package:fluttershare/models/user.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final User currentUser;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  XFile? _file;
  late File file;
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

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? buildSplashScreen(context, selectImage)
        : buildUploadForm(context, clearImage, file, widget.currentUser);
  }
}
