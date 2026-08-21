import 'package:flutter/material.dart';

import 'dart:async';

import 'package:time_stack/models/chrono_model.dart';
import 'package:time_stack/screens/modals/chronos_modif_modal.dart';

class ChronoTile extends StatefulWidget {
  const ChronoTile(this.chrono, this.removeTile, {super.key});

  final ChronoModel chrono;
  final Function removeTile;

  @override
  State<ChronoTile> createState() => _ChronoTile();
}

class _ChronoTile extends State<ChronoTile> {
  Duration timer = Duration();

  final _stopwatch = Stopwatch();
  late Duration _duration;
  late Duration _elapsedTime;
  late String _elapsedTimeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _duration = widget.chrono.elapsed;

    _elapsedTime = _duration;
    _elapsedTimeString = _formatElapsedTime(_elapsedTime);

    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer timer) {
      setState(() {
        if (_stopwatch.isRunning) {
          _updateElapsedTime();
        }
      });
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatElapsedTime(Duration time) {
    return time.toString().split('.')[0];
  }

  bool _isPomodoro() {
    return widget.chrono.elapsed.compareTo(Duration.zero) == 1;
  }

  void _updatePomodoro() {
    if (!(_duration - _stopwatch.elapsed).isNegative) {
      _elapsedTime = _duration - _stopwatch.elapsed;
      _elapsedTimeString = _formatElapsedTime(_elapsedTime);
    } else {
      _stopwatch.stop();
    }
  }

  void _updateStopWatch() {
    _elapsedTime = _stopwatch.elapsed;
    _elapsedTimeString = _formatElapsedTime(_elapsedTime);
  }

  void _updateElapsedTime() {
    if (_isPomodoro()) {
      _updatePomodoro();
    } else {
      _updateStopWatch();
    }
  }

  void _startStopStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _updateElapsedTime();
    } else {
      _stopwatch.stop();
    }
  }

  void _resetStopwatch() {
    _stopwatch.stop();
    _stopwatch.reset();
    _updateElapsedTime();
  }

  void saveChronoModif(String lbl, Duration dura) {
    setState(() {
      widget.chrono.elapsed = dura;
      _duration = dura;
      widget.chrono.setLabel = lbl;
      _updateElapsedTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) =>
              ChronosModifModal(widget.chrono, saveChronoModif),
          //widget.removeTile(widget.chrono.id);1
        ),
        onLongPress: () => widget.removeTile(widget.chrono.id),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header : Label + badge statut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.chrono.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Timer + boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _elapsedTimeString,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    letterSpacing: 1.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        _resetStopwatch();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        _startStopStopwatch();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),

                        child: !_stopwatch.isRunning
                            ? const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 28,
                              )
                            : const Icon(
                                Icons.stop_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
