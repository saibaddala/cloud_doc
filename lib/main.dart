import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reptile_run/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCJPeHPWq0feX-PQOsDakd-1kaxy-Ws0ek",
      authDomain: "reptile-run-a422a.firebaseapp.com",
      projectId: "reptile-run-a422a",
      storageBucket: "reptile-run-a422a.appspot.com",
      messagingSenderId: "180026957790",
      appId: "1:180026957790:web:9aac6b8f8e352fe4ea474f",
      measurementId: "G-M4XWHBKT2R",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reptile Run',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
