import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/views/dashboard_view.dart';
import 'package:intra_sub_mobile/app/utils/api.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  final TextEditingController nrpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GetStorage authToken = GetStorage();
  final RxBool isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    nrpController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    try {
      final response = await _getConnect.post(BaseUrl.login, {
        'nrp': nrpController.text.trim(),
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        final token = response.body['access_token'];

        if (token != null) {
          authToken.write('token', token);
          print("Token berhasil disimpan: $token");
          Get.offAll(() => const DashboardView());
        } else {
          _showErrorSnackbar('Token tidak ditemukan di respons!');
        }
      } else {
        final errorMessage = response.body['message'] ?? 'Login gagal';
        _showErrorSnackbar(errorMessage);
      }
    } catch (e) {
      _showErrorSnackbar('Terjadi kesalahan: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      icon: const Icon(Icons.error),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
