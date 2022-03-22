import 'package:flutter/material.dart';
import 'package:litter_star/screens/dashboard_tabs/time_chart.dart';
import 'package:litter_star/utils/get_hex_color.dart';
import 'package:litter_star/utils/layouts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int seletedIndex = 0;
  final PageController _pageController = PageController();

  ///set all tabs
  final List<Tab> _tabs = [
    Tab(name: "Biểu đồ thời gian", icon: Icons.bar_chart_outlined),
    Tab(name: "Nội dung đã xem", icon: Icons.history),
    Tab(name: "Bài học hoàn tất", icon: Icons.checklist_outlined),
    Tab(name: "Chúng tôi", icon: Icons.info_rounded),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          /// Tab views
          SizedBox(
            width: size.width * 0.22,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(125, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
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
                    child: Expanded(
                        child: AnimatedContainer(
                      margin: EdgeInsets.only(top: size.height * 0.1),
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
                        child: Row(children: <Widget>[
                          // Icon(
                          //   _tabs[index].icon,
                          //   color: Colors.white,
                          // ),
                          Flexible(
                            child: Text(
                              _tabs[index].name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ]),
                      ),
                    )),
                  );
                },
              ),
            ),
          ),

          /// End tab views
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
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: size.width * 0.3,
                        height: size.height * 0.15,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              "Tổng thời gian sử dụng\n3 ngày 5 giờ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                        width: size.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade700,
                          ),
                          child: const Center(
                            child: Text(
                              "Ngày cao nhất\n2 giờ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                        width: size.width * 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.greenAccent.shade400,
                          ),
                          child: const Center(
                            child: Text(
                              "Ngày thấp nhất\n20 phút",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  decoration: TextDecoration.none,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// time chart
                  const TimeChart()
                ]),

                /// History watch video
                Container(
                  child: Text("page 1"),
                ),

                /// Review lesson that complete
                Container(
                  child: Text("page 2"),
                ),

                ///About us
                Container(
                  child: Text("About us"),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class Tab {
  final String name;
  final IconData icon;

  Tab({required this.name, required this.icon});
}
