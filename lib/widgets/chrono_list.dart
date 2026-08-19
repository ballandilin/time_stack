import 'package:flutter/material.dart';
import 'package:time_stack/models/chrono_model.dart';
import 'package:time_stack/widgets/chrono_tile.dart';

class ChronoList extends StatefulWidget {
  const ChronoList({super.key});

  @override
  State<ChronoList> createState() => _ChronoList();
}

class _ChronoList extends State<ChronoList> {
  final List<ChronoModel> _chronos = <ChronoModel>[];
  late int _chronosId = 0;

  @override
  void initState() {
    super.initState();
  }

  void _addChronoTile() {
    setState(() {
      _chronos.add(ChronoModel(id: _chronosId, label: "label"));
      _chronosId++;
    });
  }

  void removeChronoTile(int id) {
    setState(() {
      _chronos.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _chronos.length,
        itemBuilder: (BuildContext context, int index) {
          return ChronoTile(
            _chronos[index],
            _chronos[index].elapsed,
            removeChronoTile,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addChronoTile,
        tooltip: 'Add Chrono',
        child: const Icon(Icons.add),
      ),
    );
  }
}
