import 'package:flutter/foundation.dart';

// TODONE: support checking of negative numbers.

class EvenChecker {
  static Future<bool> isEven(int value) async {
    if (value < 0) {
      return await compute(_isEvenWorker, ~value);
    } else {
      return await compute(_isEvenWorker, value);
    }
  }
}

int _getNthEvenNumber(int n) {
  int number = 0;
  int countEvensFound = 0;
  bool isEven = true;
  while (countEvensFound < n) {
    isEven = !isEven;
    number = number + 1;
    if (isEven) {
      countEvensFound = countEvensFound + 1;
    }
    if (countEvensFound == n) {
      break;
    }
  }
  return number;
}

bool _isEvenWorker(int value) {
  int evenNumberToCheck = 0;
  int evenNumber = 0;
  while (evenNumber < value) {
    evenNumberToCheck = evenNumberToCheck + 1;
    evenNumber = _getNthEvenNumber(evenNumberToCheck);
    if (evenNumber == value) {
      return true;
    }
  }
  return false;
}
