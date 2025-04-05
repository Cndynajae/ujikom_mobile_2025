import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intra_sub_mobile/app/data/kanban_response.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:lottie/lottie.dart';

class BoardView extends GetView<DashboardController> {
  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Pastikan controller sudah diinisialisasi
    final controller = Get.find<DashboardController>();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.getTask(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                repeat: true,
                width: MediaQuery.of(context).size.width / 1,
              ),
            );
          }

          final tasks = controller.kanbanResponse.value?.tasks;

          if (tasks == null || tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak ada data task"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.getTask(),
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.content ?? 'No Content',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text("ID: ${task.id}"),
                            backgroundColor: Colors.blue.shade100,
                          ),
                          Text(
                            "Status: ${task.statusId}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
