import 'package:mockito/mockito.dart' as _i1;
import 'package:survey/use_cases/base_use_case.dart' as _i2;
import 'package:survey/use_cases/login_use_case.dart' as _i3;
import 'dart:async' as _i4;

class _FakeResult<T> extends _i1.Fake implements _i2.Result<T> {}

/// A class which mocks [LoginUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginUseCase extends _i1.Mock implements _i3.LoginUseCase {
  MockLoginUseCase() {
    _i1.throwOnMissingStub(this);
  }

  _i4.Future<_i2.Result<void>> call(_i3.LoginCredential? credential) =>
      super.noSuchMethod(Invocation.method(#call, [credential]),
          Future.value(_FakeResult<void>()));
}
