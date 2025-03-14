import 'package:flutter/material.dart';
import 'package:wordle/app/app_colors.dart';
import 'package:wordle/wordle/models/letter_model.dart';

class BoardTile extends StatefulWidget {
  final Letter letter;

  const BoardTile({super.key, required this.letter});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  Color _getBackgroundColor() {
    switch (widget.letter.status) {
      case LetterStatus.correct:
        return correctColor;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.notInWord:
        return notInWordColor;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.letter.val.toUpperCase(),
          style: const TextStyle(
            fontSize: 40,
            color: Color.fromARGB(255, 240, 233, 233),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
