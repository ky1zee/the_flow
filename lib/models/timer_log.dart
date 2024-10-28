import 'package:isar/isar.dart';

part 'timer_log.g.dart';

@Collection()
class TimerLog{
  Id id = Isar.autoIncrement;

  // Hubungan dengan Habit
  late int habitId;

  // Waktu mulai timer
  DateTime? startTime;

  // Durasi timer dalam detik (untuk menghitung waktu yang tersisa)
  int? duration;

  // Status timer
  bool isTimerActive = false;

  // Menyimpan waktu selesai yang ditargetkan
  DateTime? targetEndTime;
}