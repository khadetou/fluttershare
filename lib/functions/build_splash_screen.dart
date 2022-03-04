import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Container buildSplashScreen(context, dynamic selectImage) {
  return Container(
    color: Theme.of(context).colorScheme.secondary,
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      SvgPicture.asset("assets/images/upload.svg", height: 260.0),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () => selectImage(context),
          child: const Text(
            "Upload Image",
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ),
      ),
    ]),
  );
}
