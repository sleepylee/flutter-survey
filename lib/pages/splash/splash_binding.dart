import 'package:get/get.dart';
import 'package:survey/api/graphql/graphql_client_provider.dart';
import 'package:survey/preferences/shared_preferences.dart';
import 'package:survey/use_cases/get_login_state_use_case.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    final sharedPref = Get.find<SharedPreferencesStorage>();
    final graphQLClientProvider = Get.find<GraphQLClientProvider>();

    // TODO: create an Authenticator instead of accessing this directly
    Get.put(GetLoginStateUseCase(sharedPref, graphQLClientProvider));
  }
}
