import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/utils/sounds.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class CheckPronunciation extends StatefulWidget {
  const CheckPronunciation({Key? key}) : super(key: key);

  @override
  _CheckPronunciationState createState() => _CheckPronunciationState();
}

class _CheckPronunciationState extends State<CheckPronunciation> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  String goalToCheck = " ${Get.parameters["param"]}";
  bool? isCheck;
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    Sounds.playUseMicro();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult, localeId: "vi_VN");
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    if (isCheck == true) {
      Sounds.playReadTrue();
    } else if (isCheck == false) {
      Sounds.playReadFalse();
    }
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    checkPronun();
  }

  void checkPronun() async {
    if (_lastWords.isNotEmpty &&
        (_lastWords.toLowerCase().contains(goalToCheck.toLowerCase()))) {
      isCheck = true;
    } else {
      isCheck = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kiểm tra phát âm chữ "$goalToCheck"'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Từ đã phát âm:',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? _lastWords
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : _speechEnabled
                            ? 'Nhấn vào hình micro để nói...'
                            : 'Chuyển đổi giọng nói thành văn bản không khả dụng',
                  ),
                  isCheck == null
                      ? Container()
                      : isCheck == true
                          ? const Text("Bé phát âm đúng rồi!")
                          : const Text(
                              "Bé phát chưa đúng rồi! Hãy thử lại nào"),
                  isCheck == true
                      ? BtnWithBG(
                          onPressed: () => Get.back(),
                          bgName: "tick_button.png",
                          text: "",
                          height: 50,
                          width: 90)
                      : Container(),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Nhấn vào đây để nói',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
