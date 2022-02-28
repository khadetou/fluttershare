import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/activity_feed.dart';
import 'package:fluttershare/widgets/profile.dart';
import 'package:fluttershare/widgets/search.dart';
import 'package:fluttershare/widgets/upload.dart';
import './timeline.dart';
import 'package:fluttershare/widgets/timeline.dart';

class BuildAuthScreen extends StatelessWidget {
  const BuildAuthScreen(
      {Key? key,
      required this.logout,
      required this.pageController,
      required this.onPageChanged,
      required this.pageIndex,
      required this.onTap})
      : super(key: key);

  final dynamic logout;
  final PageController pageController;
  final dynamic onPageChanged;
  final dynamic onTap;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey[50],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 35.0)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
