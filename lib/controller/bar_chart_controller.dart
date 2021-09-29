import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartController {
  BarChartData getBarChartData(response) => BarChartData(
        barTouchData: barTouchData(),
        titlesData: titlesData(response),
        borderData: borderData(),
        barGroups: barGroups(response),
        alignment: BarChartAlignment.spaceAround,
        maxY: 900,
      );

  barTouchData() => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) =>
              BarTooltipItem(
            "",
            const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  titlesData(response) => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (double value) => value.toInt() % 5 == 0
              ? response["data"][value.toInt()]["displayTime"]
              : "",
        ),
        // leftTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff7589a2),
              fontWeight: FontWeight.bold,
              fontSize: 10),
          margin: 10,
          reservedSize: 45,
          interval: 1,
          getTitles: (value) {
            if (value == 200) {
              return '200ms';
            } else if (value == 400) {
              return '400ms';
            } else if (value == 600) {
              return '600ms';
            } else if (value == 800) {
              return '800ms';
            } else {
              return '';
            }
          },
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  borderData() => FlBorderData(
        show: false,
      );

  barGroups(response) {
    List<BarChartGroupData> barChartGroupData = [];
    int count = 0;
    response["data"].forEach((value) {
      barChartGroupData.add(BarChartGroupData(
        x: count++,
        barRods: [
          BarChartRodData(
              y: value["ttfb"].toDouble() > 840 ? 840: value["ttfb"].toDouble(),
              colors: [Colors.lightBlueAccent, Colors.greenAccent])
        ],
        showingTooltipIndicators: [0],
      ));
    });

    return barChartGroupData;
  }
}
