import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Center buildNoContent(context) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  return Center(
    child: ListView(
      shrinkWrap: true,
      children: [
        SvgPicture.asset(
          "assets/images/search.svg",
          height: orientation == Orientation.portrait ? 300.0 : 200.0,
        ),
        const Text(
          "Find users",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 60.0),
        ),
      ],
    ),
  );
}
