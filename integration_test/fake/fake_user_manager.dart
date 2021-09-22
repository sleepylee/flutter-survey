import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:mockito/mockito.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/models/user.dart';

class FakeUserManager extends Fake implements UserManager {
  @override
  Rx<User> getCurrentUser() {
    return User(
            id: "123",
            email: "trung@nimblehq.co",
            avatarUrl:
                "https://images.firstpost.com/wp-content/uploads/2020/04/meme02-3805.jpg?impolicy=website&width=800&height=800")
        .obs;
  }

  @override
  void refresh() {
    // do nothing for now
  }
}
