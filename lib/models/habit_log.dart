import 'package:isar/isar.dart';

part 'habit_log.g.dart';

@Collection()
class HabitLog{
  Id id = Isar.autoIncrement;

  // Hubungan dengan Habit
  late int habitId;

  // Tanggal log ini (untuk kalender heat map)
  late DateTime date;

  // Status checklist
  bool isCompleted = false;

  // Timestamp saat habit dichecklist
  DateTime? completedAt;
}