import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: HexColor('#ffffff'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                'Intra-sub',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controller.nrpController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'NRP',
                  hintText: 'Masukan NRP',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Masukan Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  controller.loginNow();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
