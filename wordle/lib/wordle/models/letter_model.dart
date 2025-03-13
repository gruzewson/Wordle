import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wordle/app/app_colors.dart';

enum LetterStatus { initial, inWord, notInWord, correct }

class Letter extends Equatable {
  final LetterStatus status;
  final String val;

  const Letter({this.status = LetterStatus.initial, required this.val});

  // Add an isEmpty getter
  bool get isEmpty => val.isEmpty;

  LetterStatus get getStatus => status;
  String get getVal => val;

  factory Letter.empty() {
    return const Letter(status: LetterStatus.initial, val: '');
  }

  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial:
        return Colors.transparent;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.notInWord:
        return notInWordColor;
      case LetterStatus.correct:
        return correctColor;
    }
  }

  @override
  List<Object?> get props => [status, val];
}
