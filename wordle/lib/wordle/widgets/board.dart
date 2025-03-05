import 'package:flutter/material.dart';
import 'package:wordle/wordle/widgets/board_tile.dart';

class Board extends StatelessWidget {
  const Board({super.key, required this.board});

  final int board;//List<Word> board;

  @override
  Widget build(BuildContext context) {
  return GridView.count(
    crossAxisCount: 5, // TODO: Make this variable if needed.
    padding: EdgeInsets.fromLTRB(300, 100, 300, 100), 
    mainAxisSpacing: 10, 
    crossAxisSpacing: 10,
    children: List.generate(30, (index) { // TODO: Make this variable if needed.
      return index % 2 == 0 ? BoardTile(key: key, letter: 'B') : BoardTile(key: key, letter: 'A');
    }),
  );
}
}
