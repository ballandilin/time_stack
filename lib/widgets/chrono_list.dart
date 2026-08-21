import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_stack/models/chrono_model.dart';
import 'package:time_stack/widgets/chrono_tile.dart';

import 'dart:convert';

class ChronoList extends StatefulWidget {
  const ChronoList({super.key});

  @override
  State<ChronoList> createState() => _ChronoList();
}

class _ChronoList extends State<ChronoList> {
  List<ChronoModel> _chronos = <ChronoModel>[];
  int _chronosId = 0;
  static const String prefChronoKey = "chrono";

  @override
  void initState() {
    super.initState();
    _loadChronosData();
  }

  Future<void> _loadChronosData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(prefChronoKey);
      if (raw == null || raw.isEmpty) return;
      final List<dynamic> decoded = jsonDecode(raw);
      final chronos = decoded
          .map((e) => ChronoModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (!mounted) return;
      setState(() {
        _chronos = chronos;
        _chronosId = chronos.isEmpty
            ? 0
            : chronos.map((c) => c.id).reduce((a, b) => a > b ? a : b) + 1;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void saveChronosData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_chronos.map((c) => c.toJson()).toList());
    prefs.setString(prefChronoKey, jsonString);
  }

  void addChronoTile() {
    setState(() {
      _chronos.add(ChronoModel(id: _chronosId, label: "Title"));
      _chronosId++;
    });
    saveChronosData();
  }

  void removeChronoTile(int id) {
    setState(() {
      _chronos.removeWhere((item) => item.id == id);
    });
    saveChronosData();
  }

  void updateChronoData() {
    saveChronosData();
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
            removeChronoTile,
            updateChronoData,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addChronoTile,
        tooltip: 'Add Chrono',
        child: const Icon(Icons.add),
      ),
    );
  }
}
