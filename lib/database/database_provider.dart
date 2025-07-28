import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:the_flow/models/app_settings.dart';
import 'package:the_flow/models/habit.dart';
import 'package:path_provider/path_provider.dart';

class Database extends ChangeNotifier{
  static late Isar isar;

  // INITIALIZE
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [HabitSchema, AppSettingsSchema], directory: dir.path
    );
  }

  // LIST HABITS
  final List<Habit> currentHabit = [];

  // CREATE
  Future<void> createHabit(String habitName, hasTimer) async{
    final newHabit = Habit()
      ..name = habitName
      ..hasTimer = hasTimer;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    readHabit();
  }

  // READ
  Future<void> readHabit() async{
    List<Habit> fetchedHabit = await isar.habits.where().findAll();
    currentHabit.clear();
    currentHabit.addAll(fetchedHabit);
    notifyListeners();
  }

  // CHECKLIST
  Future<void> checklistHabit(int id, bool isCompleted) async{
    final habit =  await isar.habits.get(id);
    if(habit != null){
      await isar.writeTxn(() async {
        if(isCompleted && !habit.completedDays.contains(DateTime.now())){
          final today = DateTime.now();
          
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            )
          );
        }
        
        else{
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day
          );
        }

        await isar.habits.put(habit);
      });
    }

    readHabit();
  }

  // UPDATE HABIT
  Future<void> updateHabit(int id, String newName, bool hasTimer) async{
    final habit =  await isar.habits.get(id);

    if(habit != null){
      await isar.writeTxn(() async{
        habit.name = newName;
        habit.hasTimer = hasTimer;
        await isar.habits.put(habit);
      });
    }

    readHabit();
  }

  // DELETE HABIT
  Future<void> deleteHabit(int id) async{
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    readHabit();
  }

  Future<DateTime?> saveFirstLaunchDate() async{
    final existSettings = await isar.appSettings.where().findFirst();
    if (existSettings == null){
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async{
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }
}

