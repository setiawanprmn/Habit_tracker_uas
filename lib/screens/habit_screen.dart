import 'package:flutter/material.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
        backgroundColor: Colors.lightGreen, 
      ),
      body: const Center(
        child: Text(
          'List of Habits',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey[200], 
    );
  }
}
