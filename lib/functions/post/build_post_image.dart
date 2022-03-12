import 'package:flutter/material.dart';
import 'package:fluttershare/main.dart';

buildPostImage({required mediaUrl}) {
  return GestureDetector(
    onDoubleTap: () => logger.i("liking post"),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(mediaUrl),
      ],
    ),
  );
}
