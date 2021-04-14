import 'package:flutter/foundation.dart';

// TODONE: support checking of negative numbers.

class EvenChecker {
  static Future<bool> isEven(int value) async {
    if (value < 0) {
      return await compute(isEvenWorker, ~value);
    } else {
      return await compute(isEvenWorker, value);
    }
  }
}

int _getNthEvenNumber(int n) {
  int number = 0;
  int countEvensFound = 0;
  bool isEven = true;
  while (countEvensFound < n) {
    isEven = !isEven; // If the last number was even then this one is not.
    number = number + 1;
    if (isEven) {
      countEvensFound = countEvensFound + 1;
    }
  }
  return number;
}

bool isEvenWorker(int value) {
  int evenNumberToCheck = 0;
  int evenNumber = 0;
  while (evenNumber < value) {
    // Compare the number with every even number.  Stop if the next even
    // number is higher than the number we are testing
    evenNumberToCheck = evenNumberToCheck + 1;
    evenNumber = _getNthEvenNumber(evenNumberToCheck);
    if (evenNumber == value) {
      return true;
    }
  }
  return false;
}
