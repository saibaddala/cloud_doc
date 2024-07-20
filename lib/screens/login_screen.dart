import 'package:cloud_doc/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void googleSignIn(WidgetRef ref) {
    ref.read(authProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => googleSignIn(ref),
          label: const Text("Sign In with Google"),
          icon: Image.asset(
            "assets/glogo.png",
            width: 15,
            height: 15,
          ),
        ),
      ),
    );
  }
}
