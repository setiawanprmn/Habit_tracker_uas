import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:percobaan_setiawan/habit/habit_statistics.dart';

import '../habit/add_habit_screen.dart';
import '../habit/habit_list_screen.dart';
// import '../auth/login_page.dart';
// import '../auth/register_page.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;

  const HomeScreen({required this.username, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> healthyTips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('Email received in HomeScreen: ${widget.email}');
    fetchHealthyTips();
  }

  Future<void> fetchHealthyTips() async {
    try {
      final url = Uri.parse(
          'https://odphp.health.gov/myhealthfinder/api/v3/itemlist.json?Type=topic');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['Result']['Items']['Item'] as List<dynamic>;

        setState(() {
          healthyTips = items
              .map((item) => item['Title'] as String)
              .toList(); // Extracting Titles
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load healthy tips');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text(widget.email),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: const Icon(Icons.person, color: Colors.black),
              ),
            ),
            ListTile(
              title: const Text('Monitoring'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddHabitScreen()));
              },
            ),
            ListTile(
              title: const Text('Habit List'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HabitListScreen()));
              },
            ),
            ListTile(
              title: const Text('Result'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HabitStatisticsScreen()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.lightGreen,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text(
                    'Halo ${widget.username}, ${greeting()}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Selamat datang di Habit Tracker!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),
                if (isLoading)
                  const CircularProgressIndicator()
                else if (healthyTips.isEmpty)
                  const Text(
                    'No healthy tips available.',
                    style: TextStyle(color: Colors.red),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: healthyTips.map((tip) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    tip,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
