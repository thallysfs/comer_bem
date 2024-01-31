import 'package:comer_bem/widgets/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List monthSummary; // [janAmount, fevAmout, ... dezAmount]
  final Color colorBar;
  const MyBarGraph(
      {super.key, required this.monthSummary, required this.colorBar});

  @override
  Widget build(BuildContext context) {
    // inicialize bar data
    BarData myBarData = BarData(
      janAmount: monthSummary[0],
      fevAmount: monthSummary[1],
      marAmount: monthSummary[2],
      abrAmount: monthSummary[3],
      maiAmount: monthSummary[4],
      junAmount: monthSummary[5],
      julAmount: monthSummary[6],
      agoAmount: monthSummary[7],
      setAmount: monthSummary[8],
      outAmount: monthSummary[9],
      novAmount: monthSummary[10],
      dezAmount: monthSummary[11],
    );
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 30,
        minY: 0,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles),
          ),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: colorBar,
                    borderRadius: BorderRadius.circular(4),
                    width: 12,
                  ),
                ]))
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 11,
  );

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Jan', style: style);
      break;
    case 2:
      text = const Text('Fev', style: style);
      break;
    case 3:
      text = const Text('Mar', style: style);
      break;
    case 4:
      text = const Text('Abr', style: style);
      break;
    case 5:
      text = const Text('Mai', style: style);
      break;
    case 6:
      text = const Text('Jun', style: style);
      break;
    case 7:
      text = const Text('Jul', style: style);
      break;
    case 8:
      text = const Text('Ago', style: style);
      break;
    case 9:
      text = const Text('Set', style: style);
      break;
    case 10:
      text = const Text('Out', style: style);
      break;
    case 11:
      text = const Text('Nov', style: style);
      break;
    case 12:
      text = const Text('Dez', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
