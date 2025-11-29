import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:the_flow/pages/ongoing_page.dart';
import 'package:the_flow/models/habit.dart';


class TimerPage extends StatefulWidget {
  final Habit habit;

  const TimerPage({super.key, required this.habit});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  double _minutes = 25;
  late FixedExtentScrollController _pickerController;

  @override
  void initState() {
    super.initState();
    _pickerController = FixedExtentScrollController(initialItem: (_minutes - 5).toInt());
  }

  void _updatePickerFromSlider(double value) {
    final int index = value.round() - 5;
    if (_pickerController.selectedItem != index) {
      _pickerController.jumpToItem(index);
    }
  }

  @override
  void dispose() {
    _pickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(widget.habit.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SleekCircularSlider(
              initialValue: _minutes,
              min: 5,
              max: 120,
              onChange: (value) {
                setState(() => _minutes = value);
                _updatePickerFromSlider(value);
              },
              innerWidget: (value) {
                return Center(
                  child: SizedBox(
                    height: 100,
                    child: CupertinoPicker(
                      scrollController: _pickerController,
                      itemExtent: 40,
                      useMagnifier: true,
                      magnification: 1.2,
                      selectionOverlay: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                      ),
                      onSelectedItemChanged: (index) {
                        final selected = (index + 5).toDouble();
                        if (_minutes != selected) {
                          setState(() => _minutes = selected);
                        }
                      },
                      children: List.generate(116, (index) {
                        final minute = index + 5;
                        return Center(
                          child: Text(
                            "$minute min",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surfaceTint,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
              appearance: CircularSliderAppearance(
                size: 250,
                customColors: CustomSliderColors(
                  progressBarColor: Colors.green,
                  trackColor: Theme.of(context).colorScheme.scrim,
                  dotColor: Colors.white,
                  shadowColor: Colors.green.shade800,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.green,
              ),
              label: const Text("Start Timer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Theme.of(context).colorScheme.surfaceTint,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OngoingPage(
                      habitId: widget.habit.id,
                      habitName: widget.habit.name,
                      durationInMinutes: _minutes.toInt(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}