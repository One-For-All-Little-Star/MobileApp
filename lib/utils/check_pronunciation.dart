import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:litter_star/models/alphabet.dart';
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
  final Alphabet crrDataLesson = Hive.box("database")
      .get("alphabet")
      .where((e) => e.routeName == Get.parameters["param"])
      .toList()[0];
  late String goalToCheck;
  bool? isCheck;
  @override
  void initState() {
    super.initState();
    goalToCheck = crrDataLesson.pronunciation;
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
      checkPronun();
    });
  }

  void checkPronun() async {
    if (_lastWords.isNotEmpty &&
        (_lastWords.toLowerCase().contains(goalToCheck.toLowerCase()))) {
      isCheck = true;
      await Hive.box('database').put("pronunciation", true);
    } else {
      isCheck = false;
      await Hive.box('database').put("pronunciation", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ki???m tra ph??t ??m ch??? "${crrDataLesson.letter}"'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'T??? ???? ph??t ??m:',
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
                            ? 'Nh???n v??o h??nh micro ????? n??i...'
                            : 'Chuy???n ?????i gi???ng n??i th??nh v??n b???n kh??ng kh??? d???ng',
                  ),
                  isCheck == null
                      ? Container()
                      : isCheck == true
                          ? const Text("B?? ph??t ??m ????ng r???i!")
                          : const Text(
                              "B?? ph??t ch??a ????ng r???i! H??y th??? l???i n??o"),
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
        tooltip: 'Nh???n v??o ????y ????? n??i',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
