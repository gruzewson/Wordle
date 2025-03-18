import 'package:flutter/material.dart';
import 'package:wordle/wordle/wordle.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wordle Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WordleScreen(),
    );
  }
}