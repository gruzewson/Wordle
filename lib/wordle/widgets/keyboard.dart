import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';

const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
  ['DELETE', 'ENTER']
];

class Keyboard extends StatelessWidget {
  final Function(Letter) onLetterPressed;
  final Set<Letter> pressedLetters;

  const Keyboard({
    super.key,
    required this.onLetterPressed,
    required this.pressedLetters,
    });

    @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _qwerty.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: row.map((letter) {
            final isPressed = pressedLetters.any((element) => element.val == letter);
            final color = isPressed
                ? pressedLetters.firstWhere((element) => element.val == letter).backgroundColor
                : const Color.fromARGB(255, 114, 113, 113);
            return _KeyboardButton(
              letter: letter,
              onPressed: () => onLetterPressed(Letter(val: letter)),
              backgroundColor: color,
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}



class _KeyboardButton extends StatelessWidget {
  const _KeyboardButton({
    required this.letter,
    required this.onPressed,
    required this.backgroundColor,
  });

  final double width = 40;
  final double height = 50;
  final String letter;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0), // Add space between buttons
      width: letter == 'ENTER' || letter == 'DELETE' ? 100 : width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
            letter,
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
