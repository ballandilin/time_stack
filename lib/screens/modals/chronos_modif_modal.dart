import 'package:flutter/material.dart';
import 'package:time_stack/models/chrono_model.dart';

class ChronosModifModal extends StatelessWidget {
  const ChronosModifModal(
    this.chrono,
    this.duration,
    this.saveChronoData, {
    super.key,
  });

  final ChronoModel chrono;
  final Duration duration;
  final Function saveChronoData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(chrono.label),
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(_elapsedTime.toString().split('.')[0])],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final labelController = TextEditingController(text: widget.chrono.label);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Duration selectedDuration = duration;

        return AlertDialog(
          title: Text(chrono.label),
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(_elapsedTime.toString().split('.')[0])],
            ),
          ),
        );
      },
    );
  }
}
