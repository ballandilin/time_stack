import 'package:flutter/material.dart';
import 'package:time_stack/models/chrono_model.dart';
import 'package:wheel_picker/wheel_picker.dart';

class ChronosModifModal extends StatefulWidget {
  const ChronosModifModal(this.chrono, this.saveChronoData, {super.key});

  final ChronoModel chrono;
  final Function saveChronoData;

  @override
  State<ChronosModifModal> createState() => _ChronosModifModal();
}

class _ChronosModifModal extends State<ChronosModifModal> {
  late final _controllerText = TextEditingController(text: widget.chrono.label);

  late final Duration _duration = widget.chrono.elapsed;

  late final _hPickerWheel = WheelPickerController(
    itemCount: 24,
    initialIndex: _duration.inHours % 24,
  );
  late final _mPickerWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: _duration.inMinutes.remainder(60),
  );
  late final _sPickerWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: _duration.inSeconds.remainder(60),
  );

  @override
  void dispose() {
    _hPickerWheel.dispose();
    _mPickerWheel.dispose();
    _sPickerWheel.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget timeItemBuilder(BuildContext context, int index) {
      return Text(index.toString().padLeft(2, '0'), style: textStyle);
    }

    Widget buildTimeWheel(WheelPickerController controller, String label) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: scheme.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: WheelPicker(
                builder: timeItemBuilder,
                controller: controller,
                selectedIndexColor: scheme.primary,
                looping: true,
                style: wheelStyle,
              ),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Editing"),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controllerText,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'label',
                prefixIcon: const Icon(Icons.label_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 22,
                    child: Container(
                      height: wheelStyle.itemExtent * 1.2,
                      width: 240,
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer.withValues(alpha: .35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildTimeWheel(_hPickerWheel, "Hours"),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 55),
                        child: Text(":"),
                      ),
                      buildTimeWheel(_mPickerWheel, "Minutes"),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 55),
                        child: Text(":"),
                      ),
                      buildTimeWheel(_sPickerWheel, "Seconds"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {
            widget.saveChronoData(
              _controllerText.text,
              Duration(
                hours: _hPickerWheel.selected,
                minutes: _mPickerWheel.selected,
                seconds: _sPickerWheel.selected,
              ),
            ),
            Navigator.pop(context),
          },
          child: const Text("Save"),
        ),
        TextButton(
          onPressed: () => {Navigator.pop(context)},
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
