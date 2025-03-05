import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:wordle/app/app_colors.dart';

class BoardTile extends StatefulWidget {
  final String _letter;

  const BoardTile({super.key, required String letter}) : _letter = letter;

  String get letter => _letter;

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.VERTICAL,
      front: Container(
        width: 50, 
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 5.0, // Thickness of the border
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '', // Front side is empty
            style: TextStyle(
              fontSize: 44,
              color: const Color.fromARGB(255, 240, 233, 233), // Change color to suit your design
              decoration: TextDecoration.none
            ),
          ),
        ),
      ),
      back: Container(
        width: 50, 
        height: 50, 
        decoration: BoxDecoration(
            color: widget.letter == 'A' ? correctColor 
            : widget.letter == 'B' ? inWordColor 
            : notInWordColor,
          border: Border.all(
            color: Colors.white,
            width: 5.0, 
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            widget.letter,
            style: TextStyle(
              fontSize: 44,
              color: const Color.fromARGB(255, 240, 233, 233),
              decoration: TextDecoration.none
            ),
          ),
        ),
      ),
    );
  }
}