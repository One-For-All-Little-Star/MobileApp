import 'package:flutter/material.dart';
import 'package:litter_star/utils/layouts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimeChart extends StatefulWidget {
  const TimeChart({Key? key}) : super(key: key);

  @override
  State<TimeChart> createState() => _TimeChartState();
}

class _TimeChartState extends State<TimeChart> {
  late List<TimeUseData> _timeChartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _timeChartData = getTimeChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Column(children: [
      SizedBox(
        height: size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// Summarize time use
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
                    "Tổng thời gian sử dụng\n2 giờ 30 phút",
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
                  color: Colors.yellow.shade800,
                ),
                child: const Center(
                  child: Text(
                    "Ngày cao nhất\n50 phút",
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
                  color: Colors.greenAccent.shade700,
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
      ),

      /// time chart

      SizedBox(
        height: size.height * 0.8,
        child: SfCartesianChart(
          title: ChartTitle(text: 'Biểu đồ thời gian sử dụng'),
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            // StackedAreaSeries()
            // StackedAreaSegment()
            // StackedBarSeries()
            // StackedLineSeries
            StackedAreaSeries<TimeUseData, String>(
              dataSource: _timeChartData,
              xValueMapper: (TimeUseData data, _) => data.day,
              yValueMapper: (TimeUseData data, _) => data.watchVideo,
              name: 'Xem video\n(phút)',
              color: Colors.greenAccent.shade700,
              markerSettings: const MarkerSettings(
                isVisible: true,
              ),
            ),
            StackedAreaSeries<TimeUseData, String>(
                dataSource: _timeChartData,
                xValueMapper: (TimeUseData data, _) => data.day,
                yValueMapper: (TimeUseData data, _) => data.learn,
                name: 'Học\n(phút)',
                color: Colors.yellow.shade800,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                )),
          ],
          primaryXAxis: CategoryAxis(),
        ),
      )
    ]);
  }

  /// get data time use
  List<TimeUseData> getTimeChartData() {
    final List<TimeUseData> timeChartData = [
      TimeUseData("22/03", 12, 33),
      TimeUseData("23/03", 10, 38),
      TimeUseData("24/03", 16, 4),
      TimeUseData("25/03", 12, 25),
    ];

    return timeChartData;
  }
}

class TimeUseData {
  TimeUseData(this.day, this.watchVideo, this.learn);
  final String day;
  final num watchVideo;
  final num learn;
}
