import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordle/wordle/models/letter_model.dart';
import 'package:wordle/wordle/models/word_model.dart';
import 'package:wordle/wordle/widgets/board.dart';
import '../widgets/keyboard.dart';
import '../data/word_list.dart';
import 'dart:math';

const WORD_SIZE = 5;

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  final List<Word> _board = List.generate(
    6, 
    (_) => Word(
      letters: List.generate(WORD_SIZE, (_) => Letter.empty()),
    )
  );

  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
    6,
    (_) => List.generate(WORD_SIZE, (_) => GlobalKey<FlipCardState>()),
  );

  int _currentWordIndex = 0;
  int _currentLetterIndex = 0;

  get _currentWord => _board[_currentWordIndex];

  void _onLetterPressed(Letter letter) {
    setState(() {
      if(letter.val == 'ENTER'){
        _onEnterPressed();
      }
      else if(letter.val == 'DELETE'){
        if(_currentLetterIndex > 0){
          _currentWord.letters[_currentLetterIndex-1] = Letter.empty();
          _currentLetterIndex--;
        }
        else{
          _currentWord.letters[_currentLetterIndex] = Letter.empty();
        }
      }
      else{
        if(_currentLetterIndex < WORD_SIZE){
          _currentWord.letters[_currentLetterIndex] = letter;
          _currentLetterIndex++;
        }
      }
    });
  }

  Future<void> _onEnterPressed() async {
    if(_currentLetterIndex < WORD_SIZE){
          print("too short");
        }
        else{
          for(int i = 0; i < WORD_SIZE; i++){
            if(_currentWord.letters[i].val == solution[i]){
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.correct);
            }
            else if(solution.contains(_currentWord.letters[i].val)){
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.inWord);
            }
            else{
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.notInWord);
            }
          }
          for(int i = 0; i < WORD_SIZE; i++){
              _flipCardKeys[_currentWordIndex][i].currentState!.toggleCard();
              await Future.delayed(const Duration(milliseconds: 200));
          }
          final currentWordStr = _currentWord.letters.map((l) => l.getVal).join();
          _checkWin(currentWordStr);
          _currentWordIndex++;
          _currentLetterIndex = 0;
        }
  }
  String solution = wordList[Random().nextInt(wordList.length)];

  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      toolbarHeight: 70,
      titleSpacing: 20,
      title: const Center(
      child: Text(
        'WORDLE',
        style: TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
        ),
      ),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board, flipCardKeys: _flipCardKeys),
          const SizedBox(height: 50),
          Keyboard(onLetterPressed: _onLetterPressed),
        ],
      ),
    ),
  );
}

void _checkWin(String currentWordStr) {
  if(currentWordStr == solution){
    print("You win!");
  }
  else if(_currentWordIndex == 5){
    print("You lose!");
  }

}

}
