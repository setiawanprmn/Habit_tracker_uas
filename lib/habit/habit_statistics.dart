import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class HabitStatisticsScreen extends StatelessWidget {
  const HabitStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habits = Provider.of<HabitProvider>(context).habits;

    // Calculate the number of completed and uncompleted habits
    final completedCount = habits.where((habit) => habit.isCompleted).length;
    final uncompletedCount = habits.length - completedCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Habit Completion Statistics',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: completedCount.toDouble(),
                      title: 'Done',
                      color: Colors.green,
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: uncompletedCount.toDouble(),
                      title: 'Not Done',
                      color: Colors.red,
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                  sectionsSpace: 4,
                  centerSpaceRadius: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Completed: $completedCount',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Uncompleted: $uncompletedCount',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
