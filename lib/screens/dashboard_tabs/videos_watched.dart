import 'package:flutter/material.dart';
import 'package:litter_star/data/video_list.dart';
import 'package:litter_star/widgets/video_item.dart';

class VideosWatched extends StatefulWidget {
  const VideosWatched({Key? key}) : super(key: key);

  @override
  State<VideosWatched> createState() => _VideosWatchedState();
}

class _VideosWatchedState extends State<VideosWatched> {
  final videosWatchedList = VideoList.getVideoList();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 2,
            direction: Axis.horizontal,
            children: [
              if (videosWatchedList.isNotEmpty)
                for (var item in videosWatchedList) VideoItem(video: item)
              else
                const Center(
                  child: Text(
                    "Lịch sử trống",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 45),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
