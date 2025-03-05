import 'package:flutter/material.dart';
import 'package:wordle/wordle/widgets/board.dart';

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  @override
  Widget build(BuildContext context) {
    var board = 1;
    return Board(board: board);
  }
}