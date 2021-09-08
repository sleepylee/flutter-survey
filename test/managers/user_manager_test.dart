import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/models/user.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_profile_use_case.dart';
import 'package:test/test.dart';

import '../mocks/generate_mocks.mocks.dart';

main() {
  final mockGetProfileUseCase = MockGetProfileUseCase();
  Get.put<GetProfileUseCase>(mockGetProfileUseCase);
  final testedUserManager = UserManagerImpl();

  group('Validate UserManager behavior', () {
    when(mockGetProfileUseCase.call())
        .thenAnswer((_) async => Success(User(id: "123")));

    test(
        'When freshly started, it returns a User with id -1, then refresh value',
        () async {
      final userObs = testedUserManager.getCurrentUser();
      expect(userObs.value.id, "-1");

      // According to the implementation of getCurrentUser(), it calls refresh() and emit 1 more time
      final secondUserValue = await userObs.stream.first;
      expect(secondUserValue.id, "123");
    });

    test('When refresh is called, it returns the latest profile', () async {
      when(mockGetProfileUseCase.call())
          .thenAnswer((_) async => Success(User(id: "1234")));

      testedUserManager.refresh();

      final result = await testedUserManager.getCurrentUser().stream.first;
      expect(result.id, "1234");
    });
  });
}
