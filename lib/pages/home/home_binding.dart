import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/managers/user_manager.dart';
import 'package:survey/repositories/user_repository.dart';
import 'package:survey/use_cases/get_profile_use_case.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    final graphQLClientProvider = Get.find<GraphQLClientProvider>();
    final userRepository = UserRepositoryImpl(graphQLClientProvider.client);
    Get.put(GetProfileUseCase(userRepository));
    Get.put<UserManager>(UserManagerImpl());
  }
}
