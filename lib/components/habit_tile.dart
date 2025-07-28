import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final bool hasTimer;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  final VoidCallback? onTapHabit;

  const HabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.hasTimer,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
    this.onTapHabit,
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
          onTap:  onTapHabit,
          child: Container(
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: isCompleted
                            ? Colors.grey.shade300
                            : Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  if (hasTimer)
                    Icon(
                      PhosphorIconsBold.timer,
                      size: 20,
                      color:  Colors.orangeAccent,
                    ),
                ],
              ),
              trailing: GestureDetector(
                onTap: onTapHabit, // ⬅️ Trigger logika utama
                child: AbsorbPointer(
                  child: Checkbox(
                    activeColor: Colors.green,
                    value: isCompleted,
                    onChanged: (_) {}, // ⬅️ Dikosongkan supaya tidak trigger langsung
                    shape: const CircleBorder(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}