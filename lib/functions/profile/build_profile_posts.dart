import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/post_tile.dart';

import '../../widgets/progress.dart';

buildProfilePosts({
  required isLoading,
  required posts,
  required String postOrientation,
}) {
  if (isLoading) {
    return circularProgress();
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
