import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:the_flow/models/habit.dart';
import 'package:path_provider/path_provider.dart';

class Database extends ChangeNotifier{
  static late Isar isar;

  // INITIALIZE
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [HabitSchema], directory: dir.path
    );
  }

  // LIST HABITS
  final List<Habit> listHabit = [];

  // CREATE
  Future<void> createHabit(String habitName) async{
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit));
    readHabit();
  }

  // READ
  Future<void> readHabit() async{
    List<Habit> fetchedHabit = await isar.habits.where().findAll();
    listHabit.clear();
    listHabit.addAll(fetchedHabit);
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

  // UPDATE NAME
  Future<void> updateHabit(int id, String newName) async{
    final habit =  await isar.habits.get(id);

    if(habit != null){
      await isar.writeTxn(() async{
        habit.name = newName;
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
}