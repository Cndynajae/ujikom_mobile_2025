import 'package:get/get.dart';
import 'dart:async';
import 'package:intra_sub_mobile/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  late Timer _pindah;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _pindah = Timer.periodic(
      const Duration(seconds: 4),
      (timer) => Get.off(
        () => const LoginView(),
        transition: Transition.leftToRight,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }
}
