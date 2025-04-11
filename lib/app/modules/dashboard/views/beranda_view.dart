import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

class BerandaView extends StatelessWidget {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Obx(() {
        final tasks = controller.kanbanResponse.value?.tasks ?? [];

        final totalTugas = tasks.length;
        final tugasSelesai = tasks.where((task) => task.statusId == 3).length;
        final tugasBelumSelesai = totalTugas - tugasSelesai;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Halo, 👋",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Selamat datang Staff!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _statCard(
                icon: Icons.pending_actions,
                title: "Tugas Belum Selesai",
                value: "$tugasBelumSelesai",
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              _statCard(
                icon: Icons.check_circle_outline,
                title: "Tugas Selesai",
                value: "$tugasSelesai",
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              _statCard(
                icon: Icons.task,
                title: "Total Semua Tugas",
                value: "$totalTugas",
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 12),
            ],
          ),
        );
      }),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
