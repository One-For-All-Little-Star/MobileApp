import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:litter_star/models/video.dart';
import 'package:litter_star/routers/app_screens.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  const VideoItem({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () async {
          List temp = getVideosWatched();
          temp.toList();
          temp.add(video);
          await Hive.box('database').put("videosWatched", temp);

          Get.toNamed("${Routes.WATCH_VIDEO}?link=${video.link}");
        },
        child: Stack(
          alignment: const Alignment(-1, 1),
          children: [
            Image.network(
              video.thumbnail,
              height: size.height * 0.4,
              width: size.width * 0.3,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: size.width * 0.3,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        video.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                      ),
                      Text(
                        video.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
