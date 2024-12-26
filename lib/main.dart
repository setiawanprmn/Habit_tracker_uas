import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/login_page.dart';
import '../providers/habit_provider.dart';
import '../habit/habit_list_screen.dart';
import '../habit/habit_statistics.dart';
import '../habit/health_tips_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/habit-list': (context) => const HabitListScreen(),
        '/statistics': (context) => const HabitStatisticsScreen(),
        '/health-tips': (context) => const HealthTipsScreen(),
      },
    );
  }
}