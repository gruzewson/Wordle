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

  int _currentWordIndex = 0;
  int _currentLetterIndex = 0;

  get _currentWord => _board[_currentWordIndex];

  void _onLetterPressed(Letter letter) {
    setState(() {
      if(letter.val == 'ENTER'){
        if(_currentLetterIndex < WORD_SIZE){
          print("too short");
        }
        else{
          //TODO: flip tiles
          for(int i = 0; i < WORD_SIZE; i++){
            if(_currentWord.letters[i].val == word[i]){
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.correct);
            }
            else if(word.contains(_currentWord.letters[i].val)){
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.inWord);
            }
            else{
              _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.notInWord);
            }
          }
          final currentWordStr = _currentWord.letters.map((l) => l.getVal).join();
          _checkWin(currentWordStr);
          _currentWordIndex++;
          _currentLetterIndex = 0;
        }
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
  String word = wordList[Random().nextInt(wordList.length)];

  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    // appBar: AppBar(
    //   centerTitle: true,
    //   elevation: 0,
    //   title: const Text(
    //     'WORDLE',
    //     style: TextStyle(
    //       fontSize: 40,
    //       fontWeight: FontWeight.bold,
    //       letterSpacing: 5,
    //     )
    //   ),
    // ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(board: _board),
          const SizedBox(height: 100),
          Keyboard(onLetterPressed: _onLetterPressed),
        ],
      ),
    ),
  );
}

void _checkWin(String currentWordStr) {
  if(currentWordStr == word){
    print("You win!");
  }
  else if(_currentWordIndex == 5){
    print("You lose!");
  }

}

}
