import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:intra_sub_mobile/app/modules/kanban/views/kanban_view.dart';
import 'package:lottie/lottie.dart';

class BoardView extends GetView<DashboardController> {
  const BoardView({Key? key}) : super(key: key);

  String stripHtmlTags(String? htmlString) {
    if (htmlString == null || htmlString.isEmpty) {
      return 'No Description';
    }
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Project List',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.getProjects(),
              tooltip: 'Refresh Projects',
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Lottie.network(
                        'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Loading Projects...",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            final projects = controller.projectResponse.value?.projects;

            if (projects == null || projects.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_off,
                        size: 80, color: Colors.grey.shade400),
                    const SizedBox(height: 20),
                    Text(
                      "No Projects Found",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "There are currently no projects available",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => controller.getProjects(),
                      icon: const Icon(Icons.refresh),
                      label: const Text("Refresh"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: projects.length,
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final project = projects[index];

                // Determine status color
                Color statusColor = Colors.grey;
                final status = project.status?.name?.toLowerCase() ?? '';
                if (status.contains('active') || status.contains('ongoing')) {
                  statusColor = Colors.green;
                } else if (status.contains('pending') ||
                    status.contains('wait')) {
                  statusColor = Colors.orange;
                } else if (status.contains('completed') ||
                    status.contains('done')) {
                  statusColor = Colors.blue;
                } else if (status.contains('cancel') ||
                    status.contains('failed')) {
                  statusColor = Colors.red;
                }

                return GestureDetector(
                  onTap: () =>
                      Get.to(() => const KanbanView(), arguments: project.id),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.folder,
                                          color: Colors.blue, size: 22),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "Project ${project.id}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: statusColor,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        project.status?.name ?? 'Unknown',
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.name ?? 'No Title',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  stripHtmlTags(project.description),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (project.owner != null)
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.grey.shade200,
                                        child: Text(
                                          (project.owner!.name?.isNotEmpty ==
                                                  true)
                                              ? project.owner!.name![0]
                                                  .toUpperCase()
                                              : "?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade800,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          project.owner!.name ?? 'No Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
