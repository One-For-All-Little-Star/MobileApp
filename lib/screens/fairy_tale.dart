import 'package:flutter/material.dart';
import 'package:litter_star/json/video_list.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:get/get.dart';
import 'package:litter_star/widgets/video_item.dart';

class FairyTaleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FairyTaleController());
  }
}

class FairyTaleScreen extends GetView<FairyTaleController> {
  const FairyTaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/fairy_tales_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Header
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
                      child: TextFormField(
                        validator: controller.validator,
                        controller: controller.searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Container(
                                width: size.width * 0.1,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade700,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(Icons.search),
                              ),
                              onTap: () {
                                controller.searchVideo(
                                    controller.searchController.text);
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

            /// Show List Video
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 5,
                    direction: Axis.horizontal,
                    children: [
                      if (controller.videosShowed.isNotEmpty)
                        for (var item in controller.videosShowed)
                          VideoItem(video: item)
                      else
                        Center(
                          child: Text(
                            "Không tìm thấy truyện cổ tích nào với từ khoá\n'${controller.searchController.text}'\nVui lòng tìm kiếm lại!",
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
            )
          ],
        ),
      ),
    );
  }
}

class FairyTaleController extends GetxController {
  final searchController = TextEditingController();
  final originVideoList = VideoList.getVideoList();
  var videosShowed = VideoList.getVideoList().obs;

  @override
  void onInit() {
    searchController.text = '';
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Bạn phải nhập nội dung muốn tìm kiếm';
    }
    return null;
  }

  Future<void> searchVideo(String text) async {
    videosShowed.value = (originVideoList.where((video) =>
            video.name.toLowerCase().contains(text.toLowerCase()) == true))
        .toList();
  }
}
