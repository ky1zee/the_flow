import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/components/habit_tile.dart';
import 'package:the_flow/database/database_provider.dart';
import 'package:the_flow/models/habit.dart';
import 'package:the_flow/pages/chart_page.dart';
import 'package:the_flow/theme/theme_provider.dart';
import 'package:the_flow/pages/timer_page.dart';

import '../util/habit_util.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    Provider.of<Database>(context, listen: false).readHabit();

    super.initState();
  }

  // Text Controller
  final TextEditingController textController = TextEditingController();

  // Create New Habit
  void createNewHabit() {
    textController.clear();

    showDialog(
      context: context,
      builder: (context) {
        bool isFieldEmpty = false;
        bool enableTimer = false;

        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textController,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: "Add a new habit",
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    errorText:
                    isFieldEmpty ? "Habit's name can't be empty!" : null,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enable Focus Timer",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    CupertinoSwitch(
                      value: enableTimer,
                      onChanged: (value) => setState(() => enableTimer = value),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  String newHabitName = textController.text.trim();

                  if (newHabitName.isEmpty) {
                    setState(() {
                      isFieldEmpty = true;
                    });
                    return;
                  }

                  context.read<Database>().createHabit(newHabitName, enableTimer);

                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Check Habit True & False
  void checkHabitTrueFalse(bool? value, Habit habit) {
    // Update Habit Status
    if (value != null) {
      context.read<Database>().checklistHabit(habit.id, value);
    }
  }

  // Edit Habit
  void editHabit(Habit habit) {
    textController.text = habit.name;

    bool isFieldEmpty = false;
    bool enableTimer = habit.hasTimer;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textController,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: "Edit habit name",
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    errorText:
                    isFieldEmpty ? "Habit's name can't be empty!" : null,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enable Focus Timer",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    CupertinoSwitch(
                      value: enableTimer,
                      onChanged: (value) => setState(() => enableTimer = value),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  String newHabitName = textController.text.trim();

                  if (newHabitName.isEmpty) {
                    setState(() {
                      isFieldEmpty = true;
                    });
                    return;
                  }

                  context.read<Database>().updateHabit(
                    habit.id,
                    newHabitName,
                    enableTimer,
                  );

                  Navigator.pop(context);
                  textController.clear();
                },
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Delete Habit
  void deleteHabit(Habit habit) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
              "Are sure want to delete this habit?",
              style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          ),
          actions: [
            // delete button
            MaterialButton(
              onPressed: (){

                context.read<Database>().deleteHabit(habit.id);

                Navigator.pop(context);

              },
              child: Text(
                  'Delete',
                  style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
              ),
            ),

            // Cancel Button
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                  'Cancel',
                  style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
              ),
            ),
          ],
        )
    );
  }

  void navigateToChartPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => const ChartPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          );
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
          actions: [
            IconButton(
              icon: Icon(Icons.bar_chart_rounded),
              onPressed: navigateToChartPage,
            ),
          ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Dark Mode",
                style:
                  Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
              ),
              SizedBox(height: 8.0),
              CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Container(
        width: 82.0,
        height: 82.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 6, // Blur radius
              offset: Offset(0, 3), // Changes the position of the shadow
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: createNewHabit,
          shape: CircleBorder(),
          elevation: 0, // Remove the default elevation
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 37,
          ),
        ),
      ),

      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            navigateToChartPage(); // Change to another page with gesture
          }
        },
        child: _buildHabitList(),
      ),
    );
  }

  // Build Habit List
  Widget _buildHabitList() {
    // Habit Database
    final  database  = context.watch<Database>();

    // Current Habits
    List<Habit> currentHabits = database.currentHabit;

    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        // Return Habit Tile
        return HabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          hasTimer: habit.hasTimer,
          onChanged: (value) => checkHabitTrueFalse(value, habit),
          editHabit: (context) => editHabit (habit),
          deleteHabit: (context) => deleteHabit (habit),

          onTapHabit: () {
            if (habit.hasTimer && !isCompletedToday) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TimerPage(habit: habit),
                ),
              );
            } else {
              checkHabitTrueFalse(!isCompletedToday, habit);
            }
          },

        );
      },
    );
  }
}