import 'package:cloud_doc/authentication/providers.dart';
import 'package:cloud_doc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void googleSignIn(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final response = await ref.read(authProvider).signInWithGoogle();

    if (response.errorMsg == null) {
      print("successssssssssssssss");
      ref.read(userProvider.notifier).update((state) => response.data);
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      sMessenger.showSnackBar(
        SnackBar(
          content: Text(response.errorMsg!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => googleSignIn(ref, context),
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
