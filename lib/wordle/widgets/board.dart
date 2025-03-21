import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';
import 'package:wordle/wordle/widgets/board_tile.dart';
import 'package:wordle/wordle/models/word_model.dart';

class Board extends StatelessWidget {
  const Board({
    super.key, 
    required this.board,
    required this.flipCardKeys,
  });

  final List<Word> board;
  final List<List<GlobalKey<FlipCardState>>> flipCardKeys;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board.asMap()
      .map(
        (i, word) => MapEntry(i, Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: word.letters.asMap()
          .map(
            (j, letter) => MapEntry(
              j, 
              SizedBox(
                width: 70, // Adjust the width as needed
                height: 70, // Adjust the height as needed
                child: Padding(
                  padding: const EdgeInsets.all(4.0), // Add space between tiles
                  child: FlipCard(
                    key: flipCardKeys[i][j],
                    flipOnTouch: false,
                    direction: FlipDirection.VERTICAL,
                    front: BoardTile(
                      letter: Letter(
                        val: letter.val,
                        status: LetterStatus.initial,
                      ),
                    ),
                    back: BoardTile(letter: letter),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
        )),
      )
      .values
      .toList(),
    );
  }
}