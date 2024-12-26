import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_habit_screen.dart';
import '../providers/habit_provider.dart';
import '../providers/habit_provider.dart';
import '../habit/habit_list_screen.dart';
import '../habit/habit_statistics.dart';
import '../habit/health_tips_screen.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habits = Provider.of<HabitProvider>(context).habits;

    return Scaffold(
      appBar: AppBar(title: const Text("My Habits")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(habits[index].title),
                  trailing: Checkbox(
                    value: habits[index].isCompleted,
                    onChanged: (_) {
                      Provider.of<HabitProvider>(context, listen: false)
                          .toggleHabit(index);
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/statistics');
                },
                child: const Text('View Statistics'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/health-tips');
                },
                child: const Text('Health Tips'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddHabitScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
