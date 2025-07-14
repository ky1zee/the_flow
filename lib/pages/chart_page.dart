import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/util/habit_util.dart';

class ChartPage extends StatefulWidget{
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  @override
  void initState() {

    Provider.of<Database>(context, listen: false).readHabit();

    super.initState();
  }

  // Check Habit True & False
  void checkHabitTrueFalse(bool? value, Habit habit) {
    // Update Habit Status
    if (value != null) {
      context.read<Database>().checklistHabit(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        body: _buildChart(),
      ),
    );
  }

  Widget _buildChart() {
    final database = context.watch<Database>();
    final List<Habit> currentHabits = database.currentHabit;

    return FutureBuilder<DateTime?>(
      future: database.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Tanggal pertama tidak ditemukan'));
        }

        final datasets = generateDatasets(currentHabits);
        debugPrint("=== DATASETS GENERATED ===");
        datasets.forEach((key, value) {
          debugPrint("${key.toIso8601String()} -> $value");
        });

        return DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          child: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: HeatMapCalendar(
                initDate: snapshot.data!,
                defaultColor: Theme.of(context).colorScheme.surfaceDim,
                textColor: Colors.white,
                monthFontSize: 16,
                weekFontSize: 14,
                showColorTip: true,
                colorTipHelper: [
                  Text(
                    "Less  ",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  Text(
                    "  More",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
                colorTipCount: 5,
                colorTipSize: 14,
                flexible: true,
                colorMode: ColorMode.color,
                datasets: datasets,
                colorsets: {
                  1: Colors.green.shade200,
                  2: Colors.green.shade400,
                  3: Colors.green.shade600,
                  4: Colors.green.shade800,
                  5: Colors.green.shade900,
                },
              ),
            ),
          ),
        );
      },
    );
  }

}