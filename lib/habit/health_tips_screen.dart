import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  _HealthTipsScreenState createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  String? _tip;

  Future<void> fetchHealthTip() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/health-tips'));

    if (response.statusCode == 200) {
      setState(() {
        _tip = json.decode(response.body)['tip'];
      });
    } else {
      throw Exception('Failed to load health tip');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHealthTip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Tips")),
      body: Center(
        child: _tip != null ? Text(_tip!) : const CircularProgressIndicator(),
      ),
    );
  }
}
