import 'package:evenator/core/checker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test the edge cases', () {
    expect(isEvenWorker(0), true);
    expect(isEvenWorker(1), false);
    expect(isEvenWorker(2), true);
  });

  test('Test the positive case', () {
    expect(isEvenWorker(55), false);
    expect(isEvenWorker(100), true);
  });

  test('Test the negative Odd case', () {
    expect(isEvenWorker(-55), false);
  });

  test('Test the negative Even case', () {
    expect(isEvenWorker(-100), true);
  });
}
