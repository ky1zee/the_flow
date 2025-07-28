import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_flow/database/database_provider.dart';

class OngoingPage extends StatefulWidget {
  final int habitId;
  final String habitName;
  final int durationInMinutes;

  const OngoingPage({
    super.key,
    required this.habitId,
    required this.habitName,
    required this.durationInMinutes,
  });

  @override
  State<OngoingPage> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> with SingleTickerProviderStateMixin {
  late int _remainingSeconds;
  Timer? _timer;

  late String _randomQuote;
  Timer? _quoteTimer;

  final List<String> _quotes = [
    "Stay focused. Stay determined.",
    "One task at a time.",
    "Eliminate distractions. Win the day.",
    "Deep work brings deep results.",
    "Small steps every day.",
    "Focus is the new IQ.",
    "The more you focus, the better you get.",
    "Consistency beats motivation.",
  ];

  final Random _random = Random();

  // Lottie files Animation
  late final AnimationController _lottieController;

  // Sound players & state
  final AudioPlayer _rainPlayer = AudioPlayer();
  final AudioPlayer _windPlayer = AudioPlayer();
  final AudioPlayer _naturePlayer = AudioPlayer();
  final AudioPlayer _donePlayer = AudioPlayer();

  bool _isRainOn = false;
  bool _isWindOn = false;
  bool _isNatureOn = false;

  double _rainVolume = 0.5;
  double _windVolume = 0.5;
  double _natureVolume = 0.5;

  void _toggleSound({
    required AudioPlayer player,
    required bool isOn,
    required String asset,
    required double volume,
  }) async {
    if (isOn) {
      await player.stop();
    } else {
      await player.setReleaseMode(ReleaseMode.loop);
      await player.setVolume(volume);
      await player.play(AssetSource(asset));
    }
  }

  void _updateQuote() {
    setState(() {
      _randomQuote = _quotes[_random.nextInt(_quotes.length)];
    });
  }

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);

    _randomQuote = _quotes[_random.nextInt(_quotes.length)];
    _remainingSeconds = widget.durationInMinutes * 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        _onTimerComplete();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });

    _quoteTimer = Timer.periodic(const Duration(seconds: 7), (_) => _updateQuote());
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _timer?.cancel();
    _quoteTimer?.cancel();
    _rainPlayer.dispose();
    _windPlayer.dispose();
    _naturePlayer.dispose();
    _donePlayer.dispose();
    super.dispose();
  }

  void _onTimerComplete() async {

    await _donePlayer.setVolume(1.0);
    await _donePlayer.play(AssetSource('sounds/reward.mp3'));

    if (!mounted) return;

    await Provider.of<Database>(context, listen: false)
        .checklistHabit(widget.habitId, true);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/complete.json',
                  height: 150,
                  repeat: false,
                ),
                const SizedBox(height: 20),
                Text(
                  "You already complete this habit.\nGood Work",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                child: const Text("Next"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final minutesRemaining = (_remainingSeconds / 60).ceil();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  widget.habitName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 0),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$minutesRemaining minutes to go",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColor?.withOpacity(0.7),
                      ),
                    ),

                    const SizedBox(width: 0),

                    IconButton(
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Center(
                  child: Lottie.asset(
                    'assets/focus.json',
                    controller: _lottieController,
                    onLoaded: (composition) {
                      _lottieController
                        ..duration = composition.duration
                        ..repeat();
                    },
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 5),

                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        _randomQuote,
                        key: ValueKey(_randomQuote),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // ===  Rain Sound ===
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        PhosphorIcons.cloudRain(
                          _isRainOn
                              ? PhosphorIconsStyle.fill
                              : PhosphorIconsStyle.bold,
                        ),
                        color: _isRainOn
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() => _isRainOn = !_isRainOn);
                        _toggleSound(
                          player: _rainPlayer,
                          isOn: !_isRainOn,
                          asset: 'sounds/rain.mp3',
                          volume: _rainVolume,
                        );
                      },
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.9),
                        inactiveColor: Colors.grey.shade600.withOpacity(0.1),
                        value: _rainVolume,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        onChanged: _isRainOn
                            ? (value) {
                          setState(() => _rainVolume = value);
                          _rainPlayer.setVolume(value);
                        }
                            : null,
                      ),
                    ),
                  ],
                ),

                // ===  Wind Sound ===
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        PhosphorIcons.hurricane(
                          _isWindOn
                              ? PhosphorIconsStyle.fill
                              : PhosphorIconsStyle.bold,
                        ),
                        color: _isWindOn
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() => _isWindOn = !_isWindOn);
                        _toggleSound(
                          player: _windPlayer,
                          isOn: !_isWindOn,
                          asset: 'sounds/wind.mp3',
                          volume: _windVolume,
                        );
                      },
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.9),
                        inactiveColor: Colors.grey.shade600.withOpacity(0.1),
                        value: _windVolume,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        onChanged: _isWindOn
                            ? (value) {
                          setState(() => _windVolume = value);
                          _windPlayer.setVolume(value);
                        }
                            : null,
                      ),
                    ),
                  ],
                ),

                // ===  Nature Sound ===
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        PhosphorIcons.bird(
                          _isNatureOn
                              ? PhosphorIconsStyle.fill
                              : PhosphorIconsStyle.bold,
                        ),
                        color: _isNatureOn
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : Colors.grey.shade600,
                      ),
                      onPressed: () {
                        setState(() => _isNatureOn = !_isNatureOn);
                        _toggleSound(
                          player: _naturePlayer,
                          isOn: !_isNatureOn,
                          asset: 'sounds/nature.mp3',
                          volume: _natureVolume,
                        );
                      },
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.9),
                        inactiveColor: Colors.grey.shade600.withOpacity(0.1),
                        value: _natureVolume,
                        min: 0,
                        max: 1,
                        divisions: 10,
                        onChanged: _isNatureOn
                            ? (value) {
                          setState(() => _natureVolume = value);
                          _naturePlayer.setVolume(value);
                        }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
