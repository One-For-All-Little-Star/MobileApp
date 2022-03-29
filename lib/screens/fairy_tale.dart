import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/data/video_list.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:litter_star/widgets/video_item.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FairyTaleScreen extends StatefulWidget {
  const FairyTaleScreen({Key? key}) : super(key: key);

  @override
  State<FairyTaleScreen> createState() => _FairyTaleScreenState();
}

class _FairyTaleScreenState extends State<FairyTaleScreen> {
  ///set up search video by voice
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false, isListening = false;
  String _lastWords = '';

  ///control search video by text
  final searchController = TextEditingController();
  final originVideoList = VideoList.getVideoList();
  var videosShowed = VideoList.getVideoList();

  void searchVideo(String text) {
    setState(() {
      videosShowed = (originVideoList.where((video) =>
              video.name.toLowerCase().contains(text.toLowerCase()) == true))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      videosShowed = VideoList.getVideoList();
      searchController.text = '';
    });
    if (hasSound.value) {
      Sounds.pauseBackgroundSound();
    }

    _initSpeech();
  }

  @override
  void dispose() {
    if (hasSound.value) {
      Sounds.resumeBackgroundSound();
    }
    searchController.dispose();
    super.dispose();
  }

  ///control search video by voice

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: "vi_VN");
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    searchVideo(_lastWords);
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fairy_tales_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              /// Header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnWithBG(
                        onPressed: () => Get.back(),
                        bgName: "back_button.png",
                        text: "",
                        height: 50,
                        width: size.width * 0.12),

                    /// Search Bar
                    SizedBox(
                      width: size.width * 0.8,
                      height: 45,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20.0),
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            searchVideo(value);
                          },
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),

                            /// add suffix
                            suffix: IconButton(
                              onPressed: () {
                                searchController.clear();
                              },
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                            suffixIcon: Container(
                              width: _speechEnabled
                                  ? size.width * 0.16
                                  : size.width * 0.1,
                              decoration: BoxDecoration(
                                color: HexColor("#fbc10e"),
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(20)),
                              ),
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: _speechEnabled,
                                    child: InkWell(
                                      child: Container(
                                        width: size.width * 0.08,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          right: BorderSide(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        )),
                                        child: const Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: _speechToText.isListening
                                          ? _stopListening
                                          : _startListening,
                                    ),
                                  ),
                                  InkWell(
                                    child: SizedBox(
                                      width: size.width * 0.08,
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      searchVideo(searchController.text);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                ],
                              ),
                            ),

                            /// style boder
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                    color: Colors.yellow.shade700, width: 3)),
                            hintText: 'Tìm kiếm',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 200, 202, 202),
                                fontWeight: FontWeight.bold),
                          ),

                          /// style text input
                          style: const TextStyle(fontSize: 18),
                          maxLines: 1,
                        ),
                      ),
                    ),

                    /// End Search bar
                  ],
                ),
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
                        if (videosShowed.isNotEmpty)
                          for (var item in videosShowed) VideoItem(video: item)
                        else
                          Center(
                            child: Text(
                              "Không tìm thấy truyện cổ tích nào với từ khoá\n'${searchController.text}'\nVui lòng tìm kiếm lại!",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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

        ///black overlay when use search by voice function
        Visibility(
          visible: isListening,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Container(
              width: double.infinity,
              color: Colors.black54,
            ),
          ),
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Visibility(
        visible: isListening,
        child: RippleAnimation(
          repeat: true,
          color: Colors.blue,
          minRadius: 60,
          ripplesCount: 5,
          child: FloatingActionButton(
              onPressed: _stopListening,
              child: const Icon(Icons.mic_none_outlined)),
        ),
      ),
    );
  }
}
