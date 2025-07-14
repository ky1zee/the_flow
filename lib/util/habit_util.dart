import '../models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day,
  );
}

Map<DateTime, int> generateDatasets(List<Habit> habits) {
  final Map<DateTime, int> datasets = {};

  for (var habit in habits) {
    final uniqueDates = habit.completedDays
        .map((date) => DateTime(date.year, date.month, date.day))
        .toSet();

    for (var date in uniqueDates) {
      datasets[date] = (datasets[date] ?? 0) + 1;
    }
  }

  return datasets;
}