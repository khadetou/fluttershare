import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage({required mediaUrl}) {
  return CachedNetworkImage(
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => const Padding(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.all(20.0),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
