import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class AddHabitScreen extends StatelessWidget {
  final _habitController = TextEditingController();

  AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Habit")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _habitController,
              decoration: const InputDecoration(labelText: "Habit Name"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<HabitProvider>(context, listen: false)
                    .addHabit(_habitController.text);
                Navigator.pop(context);
              },
              child: const Text("Add Habit"),
            ),
          ],
        ),
      ),
    );
  }
}
