import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final _controllerText = TextEditingController();

  late String _labelText = widget.chrono.label;
  late Duration _duration = widget.chrono.elapsed;

  late final _hPickerWheel = WheelPickerController(
    itemCount: 24,
    initialIndex: _duration.inHours,
  );
  late final _mPickerWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: _duration.inMinutes,
  );
  late final _sPickerWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: _duration.inSeconds,
  );

  void _changeValue() {
    _labelText = _controllerText.text;
  }

  @override
  void initState() {
    super.initState();

    _controllerText.addListener(_changeValue);
  }

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
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget timeItemBuilder(BuildContext context, int index) {
      return Text("$index", style: textStyle);
    }

    return AlertDialog(
      title: TextField(controller: _controllerText),
      content: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: SizedBox(
            width: 200.0,
            height: 150.0,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: WheelPicker(
                          builder: timeItemBuilder,
                          controller: _hPickerWheel,
                          selectedIndexColor: Colors.orange,
                          looping: true,
                          style: wheelStyle,
                        ),
                      ),
                      const Text(" : ", style: textStyle),
                      Expanded(
                        child: WheelPicker(
                          builder: timeItemBuilder,
                          controller: _mPickerWheel,
                          selectedIndexColor: Colors.orange,
                          looping: true,
                          style: wheelStyle,
                        ),
                      ),
                      const Text(" : ", style: textStyle),
                      Expanded(
                        child: WheelPicker(
                          builder: timeItemBuilder,
                          controller: _sPickerWheel,
                          selectedIndexColor: Colors.orange,
                          looping: true,
                          style: wheelStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {
            _duration = Duration(
              hours: _hPickerWheel.selected,
              minutes: _mPickerWheel.selected,
              seconds: _sPickerWheel.selected,
            ),
            widget.saveChronoData(_labelText, _duration),
            Navigator.pop(context),
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
