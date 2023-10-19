import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_to_text/speech_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Voice to text',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
    );
  }
}



