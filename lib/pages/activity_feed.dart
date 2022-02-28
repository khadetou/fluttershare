import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  const ActivityFeed({Key? key}) : super(key: key);

  @override
  State<ActivityFeed> createState() => _ActivityFeedState();
}


class _ActivityFeedState extends State<ActivityFeed>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Feed'),
      ),
      body: const Center(
        child: Text('Activity Feed'),
      ),
    );
  }
}