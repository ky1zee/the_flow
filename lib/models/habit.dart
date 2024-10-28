import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit{
  Id id = Isar.autoIncrement;

  late String name;

  // Menandai apakah habit membutuhkan timer
  bool requiresTimer = false;

  // Target waktu untuk habit dalam menit (jika menggunakan timer)
  int? timerDuration;

  // Tanggal pembuatan habit
  DateTime createdAt = DateTime.now();
}