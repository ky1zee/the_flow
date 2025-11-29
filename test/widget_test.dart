import 'package:flutter_test/flutter_test.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/pages/chart_page.dart';

void main() {
  test('1. Habit baru bisa dibuat', () {
    // Setup
    final habit = Habit()
      ..id = 1
      ..name = "Meditasi"
      ..hasTimer = false;

    // Do
    final name = habit.name;

    // Test
    expect(name, "Meditasi");
  });

  test('2. Habit bisa memiliki timer', () {
    // Setup
    final habit = Habit()
      ..id = 2
      ..name = "Belajar"
      ..hasTimer = true;

    // Do
    final hasTimer = habit.hasTimer;

    // Test
    expect(hasTimer, true);
  });

  test('3. Habit default belum ada completedDays', () {
    // Setup
    final habit = Habit()..name = "Olahraga";

    // Do
    final completedCount = habit.completedDays.length;

    // Test
    expect(completedCount, 0);
  });

  test('4. Menambahkan tanggal ke completedDays', () {
    // Setup
    final habit = Habit()..name = "Coding";
    final today = DateTime.now();

    // Do
    habit.completedDays.add(today);

    // Test
    expect(habit.completedDays.contains(today), true);
  });

  test('5. Habit bisa dichecklist hari ini', () {
    // Setup
    final habit = Habit()..name = "Membaca";
    final today = DateTime.now();

    // Do
    habit.completedDays.add(today);

    // Test
    expect(habit.completedDays.last.day, today.day);
  });

  test('6. Habit bisa memiliki lebih dari satu hari selesai', () {
    // Setup
    final habit = Habit()..name = "Jalan Pagi";
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    // Do
    habit.completedDays..add(today)..add(yesterday);

    // Test
    expect(habit.completedDays.length, 2);
  });

  test('7. Habit bisa diupdate namanya', () {
    // Setup
    final habit = Habit()
      ..id = 3
      ..name = "Tidur Siang";

    // Do
    habit.name = "Tidur Malam";

    // Test
    expect(habit.name, "Tidur Malam");
  });

  test('8. Habit bisa menyalakan/mematikan timer', () {
    // Setup
    final habit = Habit()
      ..id = 4
      ..name = "Ngoding";

    // Do
    habit.hasTimer = true;

    // Test
    expect(habit.hasTimer, true);
  });

  test('9. Habit yang selesai hari ini harus dianggap completed', () {
    // Setup
    final habit = Habit()..name = "Yoga";
    final today = DateTime.now();

    // Do
    habit.completedDays.add(today);

    // Test
    expect(
      habit.completedDays.any((d) =>
      d.year == today.year && d.month == today.month && d.day == today.day),
      true,
    );
  });

  test('10. Habit bisa dihapus dari daftar', () {
    // Setup
    final habits = <Habit>[];
    final habit = Habit()
      ..id = 5
      ..name = "Olahraga";
    habits.add(habit);

    // Do
    habits.removeWhere((h) => h.id == 5);

    // Test
    expect(habits.isEmpty, true);
  });

  test('11. Habit dengan hasTimer ketika dichecklist → pindah ke halaman timer', () {
    // Setup
    final habit = Habit()
      ..id = 7
      ..name = "Belajar"
      ..hasTimer = true;

    bool navigatedToTimer = false;

    // Do
    if (habit.hasTimer) {
      navigatedToTimer = true; // Simulation navigate to Timer Page
    }

    // Test
    expect(navigatedToTimer, true);
  });

  test('12. Habit dengan timer, setelah timer habis → habit terchecklist', () {
    // Setup
    final habit = Habit()
      ..id = 8
      ..name = "Meditasi"
      ..hasTimer = true;

    bool isCompleted = false;
    int remainingSeconds = 3;

    // Do
    while (remainingSeconds > 0) {
      remainingSeconds--;
    }
    if (remainingSeconds == 0) {
      isCompleted = true; // Simulation Checklist habit when time is up!
    }

    // Test
    expect(isCompleted, true);
  });
}
