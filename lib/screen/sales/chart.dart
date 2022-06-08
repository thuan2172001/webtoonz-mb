import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/controller/sales/sales_controller.dart';
import 'package:untitled/utils/common-function.dart';

class ChartWidget extends StatelessWidget {
  final List<MonthNumberPair> data;
  final int maxValue;

  ChartWidget({Key? key, required this.data, required this.maxValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3.h, bottom: 3.h, right: 5.w),
      child: AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(BarChartData(
            maxY: 10,
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 5.h,
                    getTitlesWidget: (value, meta) {
                      var style = TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp);
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 10.0,
                          child: Text(data[value.toInt()].month, style: style));
                    }),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 10.w,
                    getTitlesWidget: (value, meta) {
                      var style = TextStyle(
                          color: Color(0xff7589a2),
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp);
                      if (maxValue == 0) {
                        return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: Text(
                                shortenNumber(100 ~/ 10 * value.toInt()),
                                style: style));
                      } else
                        return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: Text(
                                shortenNumber(maxValue ~/ 10 * value.toInt()),
                                style: style));
                    }),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: List.generate(
                data.length,
                (index) => BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                          color: Colors.blue,
                          toY: maxValue == 0
                              ? 0
                              : data[index].total / maxValue * 10.0)
                    ])),
            barTouchData: BarTouchData(touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                  data[group.x.toInt()].total.toString(),
                  TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 8.sp,
                  ));
            })))),
      ),
    );
  }
}
