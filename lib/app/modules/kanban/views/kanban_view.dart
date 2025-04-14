import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kanban_controller.dart';

class KanbanView extends GetView<KanbanController> {
  const KanbanView({super.key});

  String capitalizeEachWord(String? text) {
    if (text == null || text.isEmpty) return 'Status tidak tersedia';
    return text.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'to do':
        return Colors.grey;
      case 'in progress':
        return Colors.orange;
      case 'done':
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  IconData getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'to do':
        return Icons.pending;
      case 'in progress':
        return Icons.autorenew;
      case 'done':
        return Icons.check_circle;
      default:
        return Icons.help_outline; // Tidak dipakai lagi di UI
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KanbanController());
    final int projectId = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTask(projectId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Project $projectId'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 53, 83, 255),
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = controller.kanbanResponse.value?.tasks ?? [];

        if (tasks.isEmpty) {
          return const Center(
            child: Text(
              "Tidak ada task untuk project ini",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final status = task.status?.name;
            final displayStatus = capitalizeEachWord(status);
            final statusColor = getStatusColor(status);
            final statusIcon = getStatusIcon(status);

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name ?? 'No Task Name',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (['to do', 'in progress', 'done']
                            .contains(status?.toLowerCase())) ...[
                          Icon(statusIcon, color: statusColor),
                          const SizedBox(width: 8),
                        ],
                        Chip(
                          label: Text(displayStatus),
                          backgroundColor: statusColor.withOpacity(0.1),
                          labelStyle: TextStyle(color: statusColor),
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
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/kanban_controller.dart';

// class KanbanView extends GetView<KanbanController> {
//   const KanbanView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(KanbanController());
//     final int projectId = Get.arguments;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.getTask(projectId);
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Project #$projectId'),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final tasks = controller.kanbanResponse.value?.tasks ?? [];

//         if (tasks.isEmpty) {
//           return const Center(child: Text("Tidak ada task untuk project ini"));
//         }

//         return ListView.builder(
//           itemCount: tasks.length,
//           itemBuilder: (context, index) {
//             final task = tasks[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 title: Text(task.name ?? 'No Task Name'),
//                 subtitle: Text('Status: ${task.status ?? 'Unknown'}'),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
