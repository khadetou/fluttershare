import 'package:flutter/material.dart';

buildTogglePostOrientation(
  BuildContext context, {
  required setPostOrientation,
  required String postOrientation,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(
        icon: const Icon(Icons.grid_on),
        color: postOrientation == "grid"
            ? Theme.of(context).primaryColor
            : Colors.grey,
        onPressed: () => setPostOrientation("grid"),
      ),
      IconButton(
        icon: const Icon(Icons.list),
        color: postOrientation == "list"
            ? Theme.of(context).primaryColor
            : Colors.grey,
        onPressed: () => setPostOrientation("list"),
      ),
    ],
  );
}
/**
 *
 *
 */