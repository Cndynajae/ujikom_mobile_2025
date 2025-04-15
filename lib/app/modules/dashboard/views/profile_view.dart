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
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () {
              Get.dialog(
                Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Konfirmasi Logout",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text("Apakah Anda yakin ingin keluar?",
                            textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("Batal",
                                  style: TextStyle(color: Colors.blue)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.logout();
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text("Ya, Keluar"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder<ProfileResponse>(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                repeat: true,
                width: MediaQuery.of(context).size.width,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
                child: Text("Gagal memuat profil: ${snapshot.error}"));
          }

          final data = snapshot.data;

          if (data == null || data.email == null || data.email!.isEmpty) {
            return const Center(child: Text("Data profil tidak tersedia"));
          }

          return Stack(
            children: [
              _buildTopBackground(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    _buildAvatar(data),
                    const SizedBox(height: 12),
                    Text(
                      "${data.name ?? 'Tidak Ada Nama'}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${data.email ?? 'Tidak Ada Email'}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    _buildInfoCard(data),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopBackground() {
    return Container(
      height: 150,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(30.0), // Adjust the radius as you like
      //     bottomRight: Radius.circular(30.0), // Adjust the radius as you like
      //   ),
      // ),
    );
  }

  Widget _buildAvatar(ProfileResponse data) {
    final isValidAvatar = data.avatar != null &&
        data.avatar!.isNotEmpty &&
        (data.avatar!.startsWith("http://") ||
            data.avatar!.startsWith("https://"));

    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: isValidAvatar ? NetworkImage(data.avatar!) : null,
        child: !isValidAvatar
            ? Text(
                data.name != null && data.name!.isNotEmpty
                    ? data.name![0].toUpperCase()
                    : '',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              )
            : null,
      ),
    );
  }

  Widget _buildInfoCard(ProfileResponse data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow(Icons.person, "Nama", data.name ?? "-"),
              const SizedBox(height: 16),
              _infoRow(Icons.badge, "NRP", data.nrp ?? "-"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
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