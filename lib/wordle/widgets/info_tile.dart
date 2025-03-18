import 'package:flutter/material.dart';
import 'package:wordle/app/game_state.dart';

class InfoTile extends StatelessWidget {
  final GameState gameState;
  final String solution;

  const InfoTile({
    super.key,
    required this.gameState,
    required this.solution,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: gameState == GameState.win 
            ? const Color.fromARGB(255, 2, 114, 6) 
            : gameState == GameState.lose 
              ? const Color.fromARGB(255, 114, 2, 2)
              : const Color.fromARGB(255, 0, 0, 114),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          gameState == GameState.win 
            ? "You Win!" 
            : gameState == GameState.lose 
              ? "You Lose!\nThe word was: $solution"
              : "Too short!",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}