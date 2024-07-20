import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
          label: const Text("Sign In with Google"),
          icon: Image.asset("assets/glogo.png"),
        ),
      ),
    );
  }
}

