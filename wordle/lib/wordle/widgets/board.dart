import 'package:flutter/material.dart';
import 'package:wordle/wordle/widgets/board_tile.dart';
import 'package:wordle/wordle/models/word_model.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.board});

  final List<Word> board;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board.map((word) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.letters.map((letter) {
            return BoardTile(
              letter: letter.val,
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}