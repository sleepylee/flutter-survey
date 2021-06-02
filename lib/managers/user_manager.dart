import 'package:get/get.dart';
import 'package:survey/models/user.dart';
import 'package:survey/use_cases/base_use_case.dart';
import 'package:survey/use_cases/get_profile_use_case.dart';

const String ERROR = "error";

abstract class UserManager {
  Rx<User> getCurrentUser();

  void refresh();
}

class UserManagerImpl implements UserManager {
  final GetProfileUseCase _getProfileUseCase = Get.find<GetProfileUseCase>();

  Rx<User> _currentUser = User(id: "-1").obs;

  /// Providing the current user state, when init, it call refresh() once to fetch,
  /// In case of error, it returns a User with id: "error".
  @override
  Rx<User> getCurrentUser() {
    if (_currentUser.value.id == "-1") refresh();
    return _currentUser;
  }

  @override
  void refresh() {
    _getProfileUseCase.call().then((result) {
      if (result is Success) _currentUser.value = (result as Success).value;
      if (result is Failed) {
        _currentUser.update((currentUser) => currentUser.id = ERROR);
      }
    });
  }
}
