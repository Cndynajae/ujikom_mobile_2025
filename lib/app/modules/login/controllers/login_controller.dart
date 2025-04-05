import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/views/dashboard_view.dart';
import 'package:intra_sub_mobile/app/utils/api.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final _getConnect = GetConnect();
  TextEditingController nrpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nrpController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    final response = await _getConnect.post(BaseUrl.login, {
      'nrp': nrpController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 200) {
      // Ambil token dari 'access_token'
      final token = response.body['access_token'];
      if (token != null) {
        // Simpan token di GetStorage
        GetStorage().write('token', token);
        print(" Token berhasil disimpan: $token");

        // Pindah ke Dashboard
        Get.offAll(() => const DashboardView());
      } else {
        Get.snackbar(
          'Error',
          'Token tidak ditemukan di respons!',
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        response.body['message'] ?? 'Login gagal',
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
