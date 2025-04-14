import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

class BoardView extends GetView<DashboardController> {
  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project List'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                controller.getProjects(), // Ganti ini sesuai method-mu
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  'assets/lottie/board-2.json',
                  fit: BoxFit.contain,
                ),
              ),
            );
          }

          final projects = controller.projectResponse.value?.projects;

          if (projects == null || projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Tidak ada data project"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.getProjects(),
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: projects.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              final project = projects[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description ?? 'No Description',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text("ID: ${project.id}"),
                            backgroundColor: Colors.blue.shade100,
                          ),
                          Text(
                            "Status: ${project.status?.name ?? 'Unknown'}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (project.owner != null)
                        Text(
                          "Owner: ${project.owner!.name ?? 'No Name'}",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
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
