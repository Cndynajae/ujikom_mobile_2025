import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BerandaView extends GetView {
  const BerandaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang Staff'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BerandaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
