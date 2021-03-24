// This is a basic Flutter unit test.
// TODO: remove this class
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('When testing a group', () {
    var starter = 1;

    test('It runs sample unit test setup correctly', () {
      starter += 1;
      expect(starter == 2, true);

      starter -=1;
      expect(starter == 1, true);
    });
  });
}
