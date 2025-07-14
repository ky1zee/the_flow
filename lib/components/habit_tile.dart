import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // Edit Option
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.blue.shade200,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(10),
            ),

            // Delete Option
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: GestureDetector(
          onTap:() {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  :  Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(25)
            ),
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(
                text,
                style:
                Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isCompleted
                      ? Colors.grey.shade300
                      : Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              trailing: Checkbox(
                  activeColor: Colors.green,
                  value:  isCompleted,
                  onChanged: onChanged,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}