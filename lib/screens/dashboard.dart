import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litter_star/screens/dashboard_tabs/about_us.dart';
import 'package:litter_star/screens/dashboard_tabs/time_chart.dart';
import 'package:litter_star/screens/dashboard_tabs/videos_watched.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/layouts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int seletedIndex = 0;
  bool isHideText = false;
  final PageController _pageController = PageController();

  ///set all tabs
  late final List<Tab> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab(name: "Biểu đồ thời gian", icon: Icons.bar_chart_outlined),
      Tab(name: "Nội dung đã xem", icon: Icons.history),
      Tab(name: "Bài học hoàn tất", icon: Icons.checklist_outlined),
      Tab(name: "Chúng tôi", icon: Icons.info_rounded),
      // Tab(name: "Quay lai", icon: Icons.info_rounded),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/dashboard_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            /// Tab views menu
            SizedBox(
              width: isHideText ? size.width * 0.1 : size.width * 0.22,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(125, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// Swich type menu
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isHideText = !isHideText;
                          });
                        },
                        child: isHideText
                            ? const Icon(Icons.table_rows_rounded)
                            : const Text(
                                "Thu gọn",
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                      ),

                      /// Tabs menu
                      SizedBox(
                        height: size.height * 0.65,
                        child: ListView.separated(
                          itemCount: _tabs.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  seletedIndex = index;
                                  _pageController.jumpToPage(index);
                                });
                              },
                              child: AnimatedContainer(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.05),
                                duration: const Duration(milliseconds: 500),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: (seletedIndex == index)
                                      ? Colors.yellow.shade700
                                      : Colors.transparent,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: isHideText
                                      ? Icon(
                                          _tabs[index].icon,
                                        )
                                      : Text(
                                          _tabs[index].name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      ///Btn back
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: isHideText
                            ? const Icon(Icons.arrow_back)
                            : const Text(
                                "Quay lại",
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                      ),
                    ]),
              ),
            ),

            /// Tab views Content
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: _pageController,
                onPageChanged: (e) => {
                  setState(() {
                    seletedIndex = e;
                  })
                },
                children: [
                  ///Time use this app
                  const TimeChart(),

                  /// History watch video
                  const VideosWatched(),

                  /// Review lesson that complete
                  Container(
                    child: Text("page 2"),
                  ),

                  ///About us
                  const AboutUs(),
                  Container(
                    child: Text("Back"),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class Tab {
  final String name;
  final IconData icon;

  Tab({required this.name, required this.icon});
}
