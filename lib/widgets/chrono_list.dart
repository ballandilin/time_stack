import 'package:flutter/material.dart';
import 'package:time_stack/models/chrono_model.dart';
import 'package:time_stack/widgets/chrono_tile.dart';

class ChronoList extends StatefulWidget {
  const ChronoList({super.key});
  @override
  _ChronoList createState() => _ChronoList();
}

class _ChronoList extends State<ChronoList> {
  @override
  late List<ChronoModel> _chronos = <ChronoModel>[];

  @override
  void initState() {
    super.initState();
  }

  void _addChronoTile() {
    setState(() {
      _chronos.add(ChronoModel(id: "0", label: "label"));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _chronos.length,
        itemBuilder: (BuildContext context, int index) {
          return ChronoTile(_chronos[index].label, _chronos[index].elapsed);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addChronoTile,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
