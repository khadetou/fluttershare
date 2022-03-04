import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/models/user.dart';
import 'package:logger/logger.dart';

class UserResult extends StatelessWidget {
  const UserResult({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    Logger logger = Logger(printer: PrettyPrinter());
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(children: <Widget>[
        GestureDetector(
          onTap: () => logger.d('Tapped'),
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl)),
            title: Text(
              user.displayName,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.username,
                style: const TextStyle(color: Colors.white54)),
          ),
        ),
        const Divider(height: 2.0, color: Colors.white)
      ]),
    );
  }
}
