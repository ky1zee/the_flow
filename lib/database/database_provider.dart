import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/models/habit_log.dart';
import 'package:the_flow/models/timer_log.dart';
import 'package:path_provider/path_provider.dart';

class Database extends ChangeNotifier{
  static late Isar isar;

  // INITIALIZE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      HabitLogSchema,
      TimerLogSchema,
    ], directory: dir.path);
  }

  // CRUD OPERATION
  Future<int> addHabit(Habit habit) async {
    return await isar.writeTxn(() async => await isar.habits.put(habit));
  }

  Future<Habit?> getHabit(int id) async {
    return await isar.habits.get(id);
  }

  Future<void> updateHabit(Habit habit) async {
    await isar.writeTxn(() async => await isar.habits.put(habit));
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async => await isar.habits.delete(id));
  }

  // VISUALIZATION
  Future<List<HabitLog>> getHabitLogsForMonth(int habitId, DateTime month) async {
    return await isar.habitLogs
        .filter()
        .habitIdEqualTo(habitId)
        .dateBetween(
      DateTime(month.year, month.month, 1),
      DateTime(month.year, month.month + 1, 0),
    )
        .findAll();
  }

  // CHECK TIMER FOR CHECKLIST HABIT
  Future<void> startTimer(Habit habit, int durationInMinutes) async {
    final timerLog = TimerLog()
      ..habitId = habit.id
      ..startTime = DateTime.now()
      ..duration = durationInMinutes * 60
      ..isTimerActive = true
      ..targetEndTime = DateTime.now().add(Duration(minutes: durationInMinutes));

    await isar.writeTxn(() async => await isar.timerLogs.put(timerLog));
  }
}