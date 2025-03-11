import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: HexColor('#ffffff'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Intra-sub',
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
