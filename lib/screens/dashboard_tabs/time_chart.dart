import 'package:flutter/material.dart';
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
    return SfCartesianChart(
      title: ChartTitle(text: 'Biểu đồ thời gian sử dụng'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        StackedLineSeries<TimeUseData, String>(
            dataSource: _timeChartData,
            xValueMapper: (TimeUseData data, _) => data.day,
            yValueMapper: (TimeUseData data, _) => data.minutesUse,
            name: 'Thời gian',
            color: Colors.tealAccent,
            markerSettings: const MarkerSettings(
              isVisible: true,
            )),
        StackedLineSeries<TimeUseData, String>(
            dataSource: _timeChartData,
            xValueMapper: (TimeUseData data, _) => data.day,
            yValueMapper: (TimeUseData data, _) => data.minutesUse,
            name: 'Xem video',
            markerSettings: const MarkerSettings(
              isVisible: true,
            )),
        StackedLineSeries<TimeUseData, String>(
            dataSource: _timeChartData,
            xValueMapper: (TimeUseData data, _) => data.day,
            yValueMapper: (TimeUseData data, _) => 100,
            name: 'Học',
            markerSettings: const MarkerSettings(
              isVisible: true,
            )),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }

  /// get data time use
  List<TimeUseData> getTimeChartData() {
    final List<TimeUseData> timeChartData = [
      TimeUseData("15/03", 30),
      TimeUseData("16/03", 40),
      TimeUseData("17/03", 50),
    ];

    return timeChartData;
  }
}

class TimeUseData {
  TimeUseData(this.day, this.minutesUse);
  final String day;
  final num minutesUse;
}
