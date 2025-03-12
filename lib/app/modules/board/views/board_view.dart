import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/board_controller.dart';

class BoardView extends GetView<BoardController> {
  const BoardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BoardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BoardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
