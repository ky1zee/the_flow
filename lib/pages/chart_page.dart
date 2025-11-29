import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/util/habit_util.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  DateTime? _selectedDate = DateTime.now();
  DateTime _normalize(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void initState() {
    Provider.of<Database>(context, listen: false).readHabit();
    super.initState();
  }

  // Check Habit True & False
  void checkHabitTrueFalse(bool? value, Habit habit) {
    if (value != null) {
      context.read<Database>().checklistHabit(habit.id, value);
    }
  }

  // Count current streak
  int getCurrentStreak(List<DateTime> days) {
    final set = days.map(_normalize).toSet();
    DateTime today = _normalize(DateTime.now());
    int streak = 0;

    while (set.contains(today)) {
      streak++;
      today = today.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // Count longest streak
  int getLongestStreak(List<DateTime> days) {
    final sorted = days.map(_normalize).toList()..sort();
    if (sorted.isEmpty) return 0;

    int longest = 1, cur = 1;
    for (int i = 1; i < sorted.length; i++) {
      if (sorted[i].difference(sorted[i - 1]).inDays == 1) {
        cur++;
        longest = cur > longest ? cur : longest;
      } else {
        cur = 1;
      }
    }
    return longest;
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
          surfaceTintColor: Colors.transparent,
          iconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        body: _buildChart(),
      ),
    );
  }

  Widget _buildChart() {
    final database = context.watch<Database>();
    final List<Habit> currentHabits = database.currentHabit;

    final datasets = generateDatasets(currentHabits);

    final completedHabitsOnDate = _selectedDate == null
        ? []
        : currentHabits.where((habit) {
      return habit.completedDays.any((d) =>
      d.year == _selectedDate!.year &&
          d.month == _selectedDate!.month &&
          d.day == _selectedDate!.day);
    }).toList();

    return DefaultTextStyle(
      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
      child: Theme(
        data: Theme.of(context).copyWith(
          iconTheme:
          IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        child: Column(
          children: [
            // Heatmap Calendar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: HeatMapCalendar(
                initDate: DateTime.now(),
                defaultColor: Theme.of(context).colorScheme.surfaceDim,
                textColor: Colors.white,
                monthFontSize: 16,
                weekFontSize: 14,
                showColorTip: true,
                colorTipHelper: [
                  Text(
                    "Less  ",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  Text(
                    "  More",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
                colorTipCount: 5,
                colorTipSize: 14,
                flexible: true,
                colorMode: ColorMode.color,
                datasets: datasets,
                onClick: (selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
                onMonthChange: (newMonth) {
                  setState(() {
                    _selectedDate =
                    null;
                  });
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

            const SizedBox(height: 30),

            // Title ( Completed on ... )
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedDate != null) ...[
                    Text(
                      "Completed on ${DateFormat.yMMMMd().format(_selectedDate!)}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ] else...[
                    const SizedBox(height: 50),
                    Text(
                      "Select a date to see completed habits",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 8),

            // List Habits
            Expanded(
              child: _selectedDate == null
                  ? const SizedBox.shrink()
                  : completedHabitsOnDate.isEmpty
                  ? const Center(
                child: Text(
                  "No habit completed on this day.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: completedHabitsOnDate.length,
                itemBuilder: (context, index) {
                  final habit = completedHabitsOnDate[index];
                  return ListTile(
                    leading: const Icon(Icons.check_circle,
                        color: Colors.green),
                    title: Text(habit.name),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final now = DateTime.now();
                          final monthDays = habit.completedDays.where(
                                (d) => d.year == now.year && d.month == now.month,
                          );

                          final currentStreak = getCurrentStreak(habit.completedDays);
                          final longestStreak = getLongestStreak(habit.completedDays);

                          final selectedMonthCount = habit.completedDays.where(
                                (d) => d.year == _selectedDate!.year && d.month == _selectedDate!.month,
                          ).length;

                          final daysInSelectedMonth = DateUtils.getDaysInMonth(
                            _selectedDate!.year,
                            _selectedDate!.month,
                          );

                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(habit.name),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 12),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Completed on ${DateFormat.MMMM().format(_selectedDate!)} : $selectedMonthCount days",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const Text(
                                          "Completion rate on this month :",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  Column(
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 60.0,
                                        lineWidth: 10.0,
                                        animation: true,
                                        percent: (monthDays.length /
                                            DateUtils.getDaysInMonth(now.year, now.month))
                                            .clamp(0, 1)
                                            .toDouble(),
                                        center: Text(
                                          "${((selectedMonthCount / daysInSelectedMonth) * 100).toStringAsFixed(1)}%",
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        progressColor: Colors.green,
                                        backgroundColor: Colors.grey.shade300,
                                        circularStrokeCap: CircularStrokeCap.round,
                                      ),
                                      const SizedBox(height: 16),

                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("🌱 Current streak      : $currentStreak days"),
                                            Text("🔥 Longest streak     : $longestStreak days"),
                                            Text(
                                              "✅ Total completed   : ${habit.completedDays.length} days",
                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
