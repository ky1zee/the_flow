import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/util/habit_util.dart';
import 'package:intl/intl.dart';

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
          return const Center(child: Text('First date not found'));
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                onClick: (selectedDate) {
                  final completedHabitsOnDate = currentHabits.where((habit) {
                    return habit.completedDays.any((d) =>
                    d.year == selectedDate.year &&
                        d.month == selectedDate.month &&
                        d.day == selectedDate.day);
                  }).toList();

                  final int itemCount = completedHabitsOnDate.isEmpty ? 1 : completedHabitsOnDate.length;
                  final double baseHeightPerItem = 52;
                  final double maxHeight = baseHeightPerItem * 5;
                  final double desiredHeight = (itemCount * baseHeightPerItem).clamp(100, maxHeight);

                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) => SizedBox(
                      height: desiredHeight + 80, // +80 for padding, title, etc.
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Completed on ${DateFormat.yMMMMd().format(selectedDate)}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            if (completedHabitsOnDate.isEmpty)
                              Container(
                                height: 110,
                                alignment: Alignment.center,
                                child: const Text(
                                  "No habit completed on this day.",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            else
                              Expanded(
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: completedHabitsOnDate.map((habit) {
                                    return ListTile(
                                      leading: const Icon(Icons.check_circle, color: Colors.green),
                                      title: Text(habit.name),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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