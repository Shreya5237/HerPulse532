// lib/screens/widgets/enhanced_cycle_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Enhanced Cycle Prediction Chart Widget
class EnhancedCycleChart extends StatelessWidget {
  final List<FlSpot> dataSpots;
  const EnhancedCycleChart({super.key, required this.dataSpots});

  @override
  Widget build(BuildContext context) {
    // Brand colors
    const Color primaryColor = Color(0xFF8A3FFC);
    const Color secondaryColor = Color(0xFFFF5CA8);

    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cycle Prediction', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      horizontalInterval: 1,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (val) => FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 40,
                          getTitlesWidget: (val, _) => Text(
                            val == 1 ? 'Period' : '',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 7,
                          getTitlesWidget: (val, _) => Text(
                            'Day ${val.toInt()}',
                            style: TextStyle(color: secondaryColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: secondaryColor, width: 1),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: dataSpots,
                        isCurved: true,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF8BBD0), Color(0xFFCE93D8)],
                        ),
                        barWidth: 4,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                            radius: 4,
                            color: spot.y == 1 ? primaryColor : secondaryColor,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [primaryColor.withOpacity(0.2), Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

