import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wordle/app/game_state.dart';
import 'package:wordle/wordle/models/letter_model.dart';
import 'package:wordle/wordle/models/word_model.dart';
import 'package:wordle/wordle/widgets/board.dart';
import 'package:wordle/wordle/widgets/info_tile.dart';
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
  GameState _gameState = GameState.playing;
  final Set<Letter> _pressedLetters = {};

  get _currentWord => _board[_currentWordIndex];

  void _onPressed(Letter letter) {
    if(_gameState != GameState.playing){
      return;
    }
    setState(() {
      if(letter.val == 'ENTER'){
        _onEnterPressed();
      }
      else if(letter.val == 'DELETE'){
        _onDeletePressed();
      }
      else{
        if(_currentLetterIndex < WORD_SIZE){
          _currentWord.letters[_currentLetterIndex] = letter;
          _currentLetterIndex++;
        }
      }
    });
  }

  void _onDeletePressed() {
    if(_currentLetterIndex > 0){
      _currentWord.letters[_currentLetterIndex-1] = Letter.empty();
      _currentLetterIndex--;
    }
    else{
      _currentWord.letters[_currentLetterIndex] = Letter.empty();
    }
  }

  Future<void> _onEnterPressed() async {
    if(_currentLetterIndex < WORD_SIZE){
      print("too short");
    }
    else{
      for(int i = 0; i < WORD_SIZE; i++){
        if(_currentWord.letters[i].val == solution[i]){
          _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.correct);
          _pressedLetters.removeWhere((element) => element.val == _currentWord.letters[i].val);
          _pressedLetters.add(_currentWord.letters[i]);
        }
        else if(solution.contains(_currentWord.letters[i].val)){
          _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.inWord);
          _pressedLetters.add(_currentWord.letters[i]);
        }
        else{
          _currentWord.letters[i] = Letter(val: _currentWord.letters[i].val, status: LetterStatus.notInWord);
          _pressedLetters.add(_currentWord.letters[i]);
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
    body: Stack(
      alignment: Alignment.center,
      children: [
        Column(
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Board(board: _board, flipCardKeys: _flipCardKeys),
            const SizedBox(height: 40),
            Keyboard(onLetterPressed: _onPressed, pressedLetters: _pressedLetters),
          ],
        ),

        if (_gameState != GameState.playing)
          InfoTile(gameState: _gameState, solution: solution),
      ],
    ),
    bottomNavigationBar: BottomAppBar(
      color: Colors.blueAccent,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _restart,
            child: const Text("Restart"),
          ),
        ],
      ),
    ),
  );
}

void _checkWin(String currentWordStr) {
  setState(() {
    if (currentWordStr == solution) {
      _gameState = GameState.win;
    } else if (_currentWordIndex == 5) {
      _gameState = GameState.lose;
    }
  });
}

void _restart(){
  setState(() {
    _board
    ..clear()
    ..addAll(
     List.generate(
      6, 
      (_) => Word(
        letters: List.generate(WORD_SIZE, (_) => Letter.empty()),
      )
     ),
  );
    _flipCardKeys
    ..clear()
    ..addAll(
      List.generate(
      6,
      (_) => List.generate(WORD_SIZE, (_) => GlobalKey<FlipCardState>()),
      ),
  );
    _currentWordIndex = 0;
    _currentLetterIndex = 0;
    _gameState = GameState.playing;
    solution = wordList[Random().nextInt(wordList.length)];
    _pressedLetters.clear();
  });
}


}
