import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intra_sub_mobile/app/data/kanban_response.dart';
import 'package:intra_sub_mobile/app/data/taskstatus_response.dart';
import 'package:intra_sub_mobile/app/utils/api.dart';

class KanbanController extends GetxController {
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  final isLoading = false.obs;
  final kanbanResponse = Rxn<KanbanResponse>();
  final taskStatuses = <TaskStatus>[].obs;

  Future<void> getTaskStatuses() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.taskstatus,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.status.hasError) {
        throw Exception(response.statusText);
      }

      final result = TaskstatusResponse.fromJson(response.body);
      if (result.taskStatus != null) {
        taskStatuses.assignAll(result.taskStatus!);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat status: $e");
    }
  }

  Future<KanbanResponse?> getTask([int? projectId]) async {
    isLoading.value = true;
    try {
      if (token == null) {
        return Future.error("Token tidak ditemukan!");
      }

      final response = await _getConnect.get(
        "${BaseUrl.task}?project_id=$projectId",
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.status.hasError) {
        return Future.error(response.statusText ?? "Error tidak diketahui");
      }

      if (response.body != null) {
        final result = KanbanResponse.fromJson(response.body);
        kanbanResponse.value = result;
        return result;
      }

      return null;
    } catch (e) {
      return Future.error("Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<Task>> groupTasksByStatus(List<Task> tasks) {
    final grouped = <String, List<Task>>{
      for (var status in taskStatuses) status.name ?? 'Unknown': [],
    };

    for (var task in tasks) {
      final statusName = task.status?.name ?? 'Unknown';

      if (!grouped.containsKey(statusName)) {
        grouped[statusName] = [];
      }

      grouped[statusName]!.add(task);
    }

    return grouped;
  }

  Future<void> updateTaskStatus({
    required int taskId,
    required int newStatusId,
    required String newStatusName,
    required String newStatusColor,
  }) async {
    try {
      final taskList = kanbanResponse.value?.tasks;
      final index = taskList?.indexWhere((t) => t.id == taskId);
      if (index != null && index >= 0) {
        taskList![index!] = taskList[index!].copyWith(
          statusId: newStatusId,
          status: Status(
              id: newStatusId, name: newStatusName, color: newStatusColor),
        );
        kanbanResponse.refresh();
      }

      await _getConnect.put(
        "${BaseUrl.task}/$taskId",
        {
          "status_id": newStatusId,
        },
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal update status task: $e");
    }
  }
}

extension TaskCopy on Task {
  Task copyWith({
    int? statusId,
    Status? status,
  }) {
    return Task(
      id: id,
      name: name,
      content: content,
      ownerId: ownerId,
      responsibleId: responsibleId,
      statusId: statusId ?? this.statusId,
      status: status ?? this.status,
      projectId: projectId,
      typeId: typeId,
      priorityId: priorityId,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intra_sub_mobile/app/data/kanban_response.dart';
// import 'package:intra_sub_mobile/app/utils/api.dart';
// class KanbanController extends GetxController {
//   //TODO: Implement KanbanController
//   final box = GetStorage();
//   final _getConnect = GetConnect();
//   final token = GetStorage().read('token');
//   final isLoading = false.obs;
//   final kanbanResponse = Rxn<KanbanResponse>();

//   Future<KanbanResponse?> getTask([int? projectId]) async {
//     isLoading.value = true;
//     try {
//       if (token == null) {
//         return Future.error("Token tidak ditemukan!");
//       }

//       final response = await _getConnect.get(
//         "${BaseUrl.task}?project_id=$projectId",
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.status.hasError) {
//         return Future.error(response.statusText ?? "Error tidak diketahui");
//       }

//       if (response.body != null) {
//         final result = KanbanResponse.fromJson(response.body);
//         kanbanResponse.value = result;
//         return result;
//       }

//       return null;
//     } catch (e) {
//       return Future.error("Terjadi kesalahan: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     getTask();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }


// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:intra_sub_mobile/app/data/kanban_response.dart';
// import 'package:intra_sub_mobile/app/utils/api.dart';

// class KanbanController extends GetxController {
//   //TODO: Implement KanbanController
//   final box = GetStorage();
//   final _getConnect = GetConnect();
//   final token = GetStorage().read('token');
//   final isLoading = false.obs;
//   final kanbanResponse = Rxn<KanbanResponse>();

//   Future<KanbanResponse?> getTask([int? projectId]) async {
//     isLoading.value = true;
//     try {
//       if (token == null) {
//         return Future.error("Token tidak ditemukan!");
//       }

//       final response = await _getConnect.get(
//         "${BaseUrl.task}?project_id=$projectId",
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.status.hasError) {
//         return Future.error(response.statusText ?? "Error tidak diketahui");
//       }

//       if (response.body != null) {
//         final result = KanbanResponse.fromJson(response.body);
//         kanbanResponse.value = result;
//         return result;
//       }

//       return null;
//     } catch (e) {
//       return Future.error("Terjadi kesalahan: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     getTask();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }
// }
