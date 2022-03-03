import 'package:flutter/material.dart';

AppBar header(
  context, {
  bool isAppTitle = false,
  String? title,
  removeBackButtuon = false,
}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButtuon ? false : true,
    title: Text(
      isAppTitle ? "FlutterShare" : title!,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "Signatra" : "",
        fontSize: isAppTitle ? 50.0 : 22.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.secondary,
  );
}
