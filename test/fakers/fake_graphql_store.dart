import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/mockito.dart';

//ignore: must_be_immutable
class FakeStore extends Fake implements Store {
  // A utility flag to validate reset() has been called, similar to verify(func())
  bool isReset = false;

  @override
  void reset() {
    isReset = true;
  }
}
