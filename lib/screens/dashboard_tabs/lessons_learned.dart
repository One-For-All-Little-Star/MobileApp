import 'package:flutter/material.dart';
import 'package:litter_star/utils/globals.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:litter_star/widgets/btn_with_bg_img.dart';

class LessonsLearned extends StatefulWidget {
  const LessonsLearned({Key? key}) : super(key: key);

  @override
  State<LessonsLearned> createState() => _LessonsLearnedState();
}

class _LessonsLearnedState extends State<LessonsLearned> {
  List lessons = getAlphabetData();
  late List lessonsLearned;
  @override
  void initState() {
    var temp = [];
    for (var lesson in lessons) {
      if (!(lesson.isLock) && lesson.numOfstars > 0) {
        temp.add(lesson);
      }
    }
    setState(() {
      lessonsLearned = temp;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Center(
      child: lessonsLearned.isNotEmpty
          ? Wrap(
              alignment: WrapAlignment.start,
              children: [
                for (var item in lessonsLearned)
                  BtnWithBG(
                    onPressed: () {},
                    bgName: item.isLock
                        ? "lock.png"
                        : item.numOfstars == 0
                            ? "none_star.png"
                            : item.numOfstars == 1
                                ? "one_star.png"
                                : item.numOfstars == 2
                                    ? "two_star.png"
                                    : "three_star.png",
                    text: item.isLock ? "" : item.letter,
                    height: size.height * 0.2,
                    width: size.height * 0.2,
                    isCenter: false,
                    pdTop: size.height * 0.04,
                  )
              ],
            )
          : const Text(
              "Bé chưa học bài nào",
              textAlign: TextAlign.center,
              style: TextStyle(
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontSize: 45),
            ),
    );
  }
}
