import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:amazone_clone/features/admin/models/sales.dart';

class EarningChart extends StatefulWidget {
  final List<Sales>? sales;

  const EarningChart({super.key, required this.sales});

  @override
  _EarningChartState createState() => _EarningChartState();
}

class _EarningChartState extends State<EarningChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: widget.sales != null
              ? widget.sales!
                      .map((e) => e.earnings)
                      .reduce((a, b) => a > b ? a : b) +
                  10
              : 200,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.blueGrey,
              tooltipHorizontalAlignment: FLHorizontalAlignment.right,
              tooltipMargin: -10,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final salesData = widget.sales?[groupIndex];
                return BarTooltipItem(
                  '${salesData?.label ?? ''}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${rod.toY.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (event, response) {
              setState(() {
                touchedIndex = response?.spot?.touchedBarGroupIndex ?? -1;
              });
            },
          ),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true, // Enable titles data
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index < widget.sales!.length) {
                    // Display category names
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.sales![index].label,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Hide left titles
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Hide right titles
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          barGroups: widget.sales!
              .asMap()
              .entries
              .map(
                (entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.earnings.toDouble(),
                      color: touchedIndex == entry.key
                          ? Colors.green
                          : Colors.blue,
                      width: 15,
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 190,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
