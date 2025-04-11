import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/data/profile_response.dart';
import 'package:intra_sub_mobile/app/modules/profile/controllers/profile_controller.dart';
import 'package:lottie/lottie.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        centerTitle: true,
        actions: [
        Container(
            margin: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.white,
                    child: Container(
                      width: Get.width * 0.8,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Konfirmasi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Apakah anda ingin Keluar?",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  "Batal",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.logout();
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Ya, Keluar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label:
                  const Text("Logout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () {
          //     Get.defaultDialog(
          //         title: "Konfirmasi",
          //         middleText: "Apakah anda ingin Keluar ?",
          //         textConfirm: "Ya, Keluar",
          //         textCancel: "Batal",
          //         confirmTextColor: Colors.white,
          //         onConfirm: () {
          //           controller.logout();
          //           Get.back();
          //         },
          //         onCancel: () {
          //           Get.back();
          //         });
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<ProfileResponse>(
            future: controller.getProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.network(
                    'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                    repeat: true,
                    width: MediaQuery.of(context).size.width / 1,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircularProgressIndicator();
                    },
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Failed to load profile: ${snapshot.error}"),
                );
              }

              final data = snapshot.data;

              if (data == null || data.email == null || data.email!.isEmpty) {
                return const Center(child: Text("No profile data available"));
              }

              // Debug avatar URL
              print("Avatar URL: ${data.avatar}");

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar handler with fallback
                  _buildAvatar(data),
                  const SizedBox(height: 16),
                  Text(
                    "${data.name ?? 'No Name'}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("${data.email ?? 'No Email'}"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ProfileResponse data) {
    // Check if avatar URL exists and is not empty
    if (data.avatar != null && data.avatar!.isNotEmpty) {
      // Try to validate URL format
      bool isValidUrl = data.avatar!.startsWith('http://') ||
          data.avatar!.startsWith('https://');

      if (isValidUrl) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
        );
      }
    }

    // Fallback if no valid avatar URL
    return _buildFallbackAvatar(data);
  }

  Widget _buildFallbackAvatar(ProfileResponse data) {
    String initial = '';
    if (data.name != null && data.name!.isNotEmpty) {
      initial = data.name![0].toUpperCase();
    }

    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:intra_sub_mobile/app/data/profile_response.dart';
// import 'package:intra_sub_mobile/app/modules/profile/controllers/profile_controller.dart';
// import 'package:lottie/lottie.dart';

// class ProfileView extends GetView<ProfileController> {
//   @override
//   final ProfileController controller = Get.put(ProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PROFILE'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               Get.defaultDialog(
//                   title: "Konfirmasi",
//                   middleText: "Apakah anda ingin Keluar ?",
//                   textConfirm: "Ya, Keluar",
//                   textCancel: "Batal",
//                   confirmTextColor: Colors.white,
//                   onConfirm: () {
//                     controller.logout();
//                     Get.back();
//                   },
//                   onCancel: () {
//                     Get.back();
//                   });
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: FutureBuilder<ProfileResponse>(
//             future: controller.getProfile(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Lottie.network(
//                     'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
//                     repeat: true,
//                     width: MediaQuery.of(context).size.width / 1,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Text("Loading animation failed");
//                     },
//                   ),
//                 );
//               }

//               if (snapshot.hasError) {
//                 return const Center(
//                   child: Text("Failed to load profile"),
//                 );
//               }

//               final data = snapshot.data;

//               if (data == null || data.email == null || data.email!.isEmpty) {
//                 return const Center(child: Text("No profile data available"));
//               }

//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (data.avatar != null)
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(data.avatar!),
//                       radius: 50,
//                     ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "${data.name}",
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(" ${data.email}"),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }