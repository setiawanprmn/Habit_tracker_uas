import 'package:flutter/foundation.dart';

class Habit {
  final String title;
  bool isCompleted;

  Habit({required this.title, this.isCompleted = false});
}

class HabitProvider with ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  void addHabit(String title) {
    _habits.add(Habit(title: title));
    notifyListeners();
  }

  void toggleHabit(int index) {
    _habits[index].isCompleted = !_habits[index].isCompleted;
    notifyListeners();
  }
}
