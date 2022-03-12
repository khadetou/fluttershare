import 'package:flutter/material.dart';
import 'package:fluttershare/main.dart';

buildPostFooter(
    {required int likeCount,
    required String username,
    required String description}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
          GestureDetector(
            onTap: () => logger.i("Liking post"),
            child: const Icon(
              Icons.favorite_border,
              size: 28.0,
              color: Colors.pink,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20.0)),
          GestureDetector(
            onTap: () => logger.i("Showing comments"),
            child: Icon(
              Icons.chat,
              size: 28.0,
              color: Colors.blue[900],
            ),
          ),
        ],
      ),
      Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Text(
              "$likeCount likes",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Text(
              username,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(description),
          ),
        ],
      ),
    ],
  );
}
