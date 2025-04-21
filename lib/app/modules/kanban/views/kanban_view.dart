import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/data/kanban_response.dart';
import '../controllers/kanban_controller.dart';

class KanbanView extends GetView<KanbanController> {
  const KanbanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KanbanController());
    final int projectId = Get.arguments;

    // Load data setelah build pertama
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getTaskStatuses();
      await controller.getTask(projectId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Project $projectId'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final allTasks = controller.kanbanResponse.value?.tasks ?? [];

        // Filter tasks berdasarkan project ID yang diterima dari arguments
        final projectTasks =
            allTasks.where((task) => task.projectId == projectId).toList();

        if (controller.taskStatuses.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final groupedTasks = controller.groupTasksByStatus(projectTasks);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: controller.taskStatuses.where((status) {
              final statusName = status.name?.toLowerCase() ?? '';
              return !statusName.contains('archive') && statusName != '';
            }).map((status) {
              final taskList = groupedTasks[status.name] ?? [];
              return _buildStatusColumn(
                status.name ?? 'Unknown',
                taskList,
                controller,
                status,
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildStatusColumn(
    String statusName,
    List<Task> tasks,
    KanbanController controller,
    statusObj,
  ) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: MediaQuery.of(Get.context!).size.height * 0.7,
                  child: DragTarget<Task>(
                    onAccept: (receivedTask) {
                      debugPrint(
                          "Task ${receivedTask.name} dropped on $statusName");
                      if (receivedTask.statusId != statusObj.id) {
                        controller.updateTaskStatus(
                          taskId: receivedTask.id!,
                          newStatusId: statusObj.id!,
                          newStatusName: statusObj.name ?? 'Unknown',
                          newStatusColor: statusObj.color ?? '#000000',
                        );
                      }
                    },
                    builder: (context, candidateData, rejectedData) =>
                        Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView(
                        children: tasks.map((task) {
                          return Draggable<Task>(
                            data: task,
                            feedback: Material(
                              type: MaterialType.transparency,
                              child: SizedBox(
                                width: 280,
                                child: Card(
                                  elevation: 4,
                                  child: ListTile(
                                    title: Text(task.name ?? ''),
                                  ),
                                ),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.5,
                              child: _buildTaskCard(task),
                            ),
                            child: _buildTaskCard(task),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 2,
      child: ListTile(
        title: Text(task.name ?? 'No Task Name'),
        subtitle: Text('Status: ${task.status?.name ?? 'Unknown'}'),
      ),
    );
  }
}
