import 'package:flutter/material.dart';
import 'package:wordle/wordle/widgets/board.dart';
import '../widgets/keyboard.dart';

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  @override
  Widget build(BuildContext context) {
    String word = 'testo';
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Board(word: word),
          ),
          Expanded(
            flex: 1,
            child: Keyboard(),
          ),
        ],
      ),
    );
  }
}