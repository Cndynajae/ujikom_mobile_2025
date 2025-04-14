import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intra_sub_mobile/app/data/kanban_response.dart';
import 'package:intra_sub_mobile/app/utils/api.dart';

class KanbanController extends GetxController {
  //TODO: Implement KanbanController
  final box = GetStorage();
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');
  final isLoading = false.obs;
  final kanbanResponse = Rxn<KanbanResponse>();

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

  @override
  void onInit() {
    super.onInit();
    getTask();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
