import 'package:equatable/equatable.dart';
import 'letter_model.dart';

class Word extends Equatable {
  final List<Letter> letters;

  const Word({required this.letters});

  factory Word.fromString(String word) {
    return Word(letters: word.split('').map((letter) => Letter(val: letter)).toList());
  }

  String get wordString => letters.map((letter) => letter.val).join();

  void addLetter(String letter) {
    final index = letters.indexWhere((element) => element.val.isNotEmpty);
    if (index != -1) {
      letters[index] = Letter(val: letter);
    }
  }

  void removeLetter() {
    final index = letters.indexWhere((element) => element.val.isNotEmpty);
    if (index != -1) {
      letters[index] = Letter.empty();
    }
  }

   @override
  List<Object> get props => [letters];
}