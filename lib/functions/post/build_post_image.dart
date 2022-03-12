import 'package:flutter/material.dart';
import 'package:fluttershare/main.dart';
import "../profile/custom_image.dart";

buildPostImage({required mediaUrl}) {
  return GestureDetector(
    onDoubleTap: () => logger.i("liking post"),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        cachedNetworkImage(mediaUrl: mediaUrl),
      ],
    ),
  );
}
