import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineModeScreen extends StatefulWidget {
  const OfflineModeScreen({super.key});

  @override
  _OfflineModeScreenState createState() => _OfflineModeScreenState();
}

class _OfflineModeScreenState extends State<OfflineModeScreen> {
  String? _data;

  Future<void> saveData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('habit_data', data);
    setState(() {
      _data = data;
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = prefs.getString('habit_data') ?? 'No data saved';
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offline Mode")),
      body: Column(
        children: [
          Text(_data ?? 'Loading...'),
          ElevatedButton(
            onPressed: () => saveData('Sample Habit Data'),
            child: const Text("Save Data"),
          ),
        ],
      ),
    );
  }
}
