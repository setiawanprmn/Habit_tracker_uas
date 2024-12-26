import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'dart:convert';
import 'register_page.dart';
import '../screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String loginMessage = '';

  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings = prefs.getStringList('users') ?? [];

    String? matchedEmail;
    bool isAuthenticated = userStrings.any((userString) {
      Map<String, String> user = Map<String, String>.from(json.decode(userString));
      if (user['username'] == usernameController.text &&
          user['password'] == passwordController.text) {
              matchedEmail = user['email'];
              return true;
            }
      return false;
    });

    if (isAuthenticated && matchedEmail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: usernameController.text,
            email: matchedEmail!,
          ),
        ),
      );
    } else {
      setState(() {
        loginMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (loginMessage.isNotEmpty)
              Text(
                loginMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(color: Colors.black), // Style for the regular text
                children: [
                  TextSpan(
                    text: "Register here!",
                    style: const TextStyle(
                      color: Colors.blue, // Style for the button-like text
                      decoration: TextDecoration.underline, // Optional: to make it look clickable
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                  ),
                ],
              ),
            ),

            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ViewRegisteredUsers()),
            //     );
            //   },
            //   child: Text("View Registered Users"),
            // ),
          ],
        ),
      ),
    );
  }
}
