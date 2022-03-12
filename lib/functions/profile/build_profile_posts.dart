import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/widgets/post_tile.dart';

import '../../widgets/progress.dart';

buildProfilePosts({
  required isLoading,
  required posts,
  required String postOrientation,
}) {
  if (isLoading) {
    return circularProgress();
  } else if (posts.isEmpty) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/no_content.svg',
          height: 260.0,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            "No Posts",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  } else if (postOrientation == "grid") {
    List<GridTile> gridTiles = [];
    posts.forEach((post) {
      gridTiles.add(
        GridTile(
          child: PostTile(
            post: post,
          ),
        ),
      );
    });
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.5,
      crossAxisSpacing: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: gridTiles,
    );
  } else if (postOrientation == "list") {
    return Column(
      children: posts,
    );
  }
}
