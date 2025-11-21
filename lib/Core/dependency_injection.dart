import 'package:get/get.dart';

import '../Controller/auth_controller.dart';
import '../Controller/chat_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(),fenix: true);
    Get.lazyPut<ChatController>(() => ChatController(),fenix: true);

  }
}
