import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
import 'package:litter_star/models/alphabet.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';
import 'package:provider/provider.dart';
import 'painter.dart';

class HandwriteScreen extends StatelessWidget {
  HandwriteScreen({Key? key}) : super(key: key);
  final Alphabet crrDataLesson = Hive.box("database")
      .get("alphabet")
      .where((e) => e.routeName == Get.parameters["param"])
      .toList()[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chữ cần viết là "${crrDataLesson.letter.toLowerCase()}" hoặc "${crrDataLesson.letter.toUpperCase()}"',
          style: const TextStyle(fontFamily: "HP"),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => HandwriteState(),
        child: const Handwrite(),
      ),
    );
  }
}

class Handwrite extends StatefulWidget {
  const Handwrite({Key? key}) : super(key: key);

  @override
  _HandwriteState createState() => _HandwriteState();
}

class _HandwriteState extends State<Handwrite> {
  final String _model = 'vi-VN';
  HandwriteState get state => Provider.of(context, listen: false);
  late DigitalInkRecognition _recognition;
  double get _width => MediaQuery.of(context).size.width * 0.6;
  double get _height => MediaQuery.of(context).size.height;
  late String goalToCheck;
  final Alphabet crrDataLesson = Hive.box("database")
      .get("alphabet")
      .where((e) => e.routeName == Get.parameters["param"])
      .toList()[0];

  @override
  void initState() {
    super.initState();
    _recognition = DigitalInkRecognition(model: _model);
    goalToCheck = crrDataLesson.letter;
  }

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  // need to call start() at the first time before painting the ink
  Future<void> _init() async {
    await _recognition.start(writingArea: Size(_width, _height));
    // always check the availability of model before being used for recognition
    await _checkModel();
  }

  // reset the ink recognition
  Future<void> _reset() async {
    state.reset();
    await _recognition.start(writingArea: Size(_width, _height));
  }

  Future<void> _checkModel() async {
    bool isDownloaded = await DigitalInkModelManager.isDownloaded(_model);

    if (!isDownloaded) {
      await DigitalInkModelManager.download(_model);
    }
  }

  Future<void> _actionDown(Offset point) async {
    state.startWriting(point);
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    state.writePoint(point);
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp() async {
    state.stopWriting();
    await _recognition.actionUp();
  }

  Future<void> _startRecognition() async {
    if (state.isNotProcessing) {
      state.startProcessing();
      // always check the availability of model before being used for recognition
      await _checkModel();
      state.data = await _recognition.process();
      state.stopProcessing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (_) {
            _init();

            return GestureDetector(
              onScaleStart: (details) async =>
                  await _actionDown(details.localFocalPoint),
              onScaleUpdate: (details) async =>
                  await _actionMove(details.localFocalPoint),
              onScaleEnd: (details) async => await _actionUp(),
              child: Consumer<HandwriteState>(
                builder: (_, state, __) => CustomPaint(
                  painter: DigitalInkPainter(writings: state.writings),
                  child: SizedBox(
                    width: _width,
                    height: _height,
                  ),
                ),
              ),
            );
          },
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BtnWithBG(
                    onPressed: _startRecognition,
                    bgName: "long_btn_yellow.png",
                    text: 'Kiểm tra',
                    height: 50,
                    width: 100,
                    fontSize: 18,
                  ),
                  BtnWithBG(
                    onPressed: _reset,
                    bgName: "long_btn_green.png",
                    text: 'Viết lại',
                    height: 50,
                    width: 100,
                    fontSize: 18,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Chữ đã viết:",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "HP",
                ),
              ),
              Center(
                child: Consumer<HandwriteState>(builder: (_, state, __) {
                  if (state.isNotProcessing && state.isNotEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(children: [
                          Text(
                            state.toString(),
                            textAlign: TextAlign.center,
                            style:
                                const TextStyle(fontSize: 20, fontFamily: "HP"),
                          ),
                          const Text(
                            "Kết quả bài làm:",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: "HP",
                            ),
                          ),
                          Text(
                            state.checkResult(goalToCheck)
                                ? "Hoàn toàn chính xác"
                                : "Chưa đúng rồi!\nHãy thử lại lần nữa.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "HP",
                            ),
                          ),
                          state.checkResult(goalToCheck)
                              ? BtnWithBG(
                                  onPressed: () => Get.back(),
                                  bgName: "tick_button.png",
                                  text: "",
                                  height: 50,
                                  width: 90)
                              : Container()
                        ]),
                      ),
                    );
                  }

                  if (state.isProcessing) {
                    return Center(
                      child: Container(
                        width: 36,
                        height: 36,
                        color: Colors.transparent,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return Container();
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HandwriteState extends ChangeNotifier {
  List<List<Offset>> _writings = [];
  List<RecognitionCandidate> _data = [];
  bool isProcessing = false;
  List<List<Offset>> get writings => _writings;
  List<RecognitionCandidate> get data => _data;
  bool get isNotProcessing => !isProcessing;
  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;

  List<Offset> _writing = [];

  void reset() {
    _writings = [];
    notifyListeners();
  }

  void startWriting(Offset point) {
    _writing = [point];
    _writings.add(_writing);
    notifyListeners();
  }

  void writePoint(Offset point) {
    if (_writings.isNotEmpty) {
      _writings[_writings.length - 1].add(point);
      notifyListeners();
    }
  }

  void stopWriting() {
    _writing = [];
    notifyListeners();
  }

  void startProcessing() {
    isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    isProcessing = false;
    notifyListeners();
  }

  set data(List<RecognitionCandidate> data) {
    _data = data;
    notifyListeners();
  }

  @override
  String toString() {
    return isNotEmpty ? _data.first.text : '';
  }

  String toCompleteString() {
    return isNotEmpty ? _data.map((c) => c.text).toList().join(', ') : '';
  }

  bool checkResult(String goalToCheck) {
    bool result = _data.first.text.toLowerCase() == goalToCheck.toLowerCase();
    if (result) {
      Hive.box('database').put("writing", true);
    } else {
      Hive.box('database').put("writing", false);
    }
    return result;
  }
}
