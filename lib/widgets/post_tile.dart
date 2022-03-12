import 'package:flutter/material.dart';
import 'package:fluttershare/functions/profile/custom_image.dart';
import 'package:fluttershare/main.dart';
import 'package:fluttershare/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  const PostTile({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => logger.i("Showing post"),
      child: cachedNetworkImage(mediaUrl: post.mediaUrl),
    );
  }
}
