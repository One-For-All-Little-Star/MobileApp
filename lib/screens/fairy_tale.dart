import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:litter_star/json/video_list.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:get/get.dart';
import 'package:litter_star/widgets/video_item.dart';

class FairyTaleScreen extends StatelessWidget {
  const FairyTaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    final videoList = VideoList.getVideoList();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/fairy_tales_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              BtnWithBG(
                  onPressed: () => Get.back(),
                  bgName: "long_btn_yellow.png",
                  text: "Quay lại",
                  height: 50,
                  width: 90),

              /// Search Bar
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: 45,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                            child: Container(
                              width: size.width * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.shade700,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(Icons.search),
                            ),
                            onTap: () {
                              print("Pressed");
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: Colors.yellow.shade700, width: 3)),
                          hintText: 'Tìm kiếm',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 200, 202, 202),
                              fontWeight: FontWeight.bold),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.only(left: 20, top: 10),
                          focusColor: Colors.red),
                      style: const TextStyle(fontSize: 15),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),

              /// End Search bar
            ],
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 5,
                  direction: Axis.horizontal,
                  children: [
                    for (var item in videoList) VideoItem(video: item)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
