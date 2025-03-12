import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intra_sub_mobile/app/data/kanban_response.dart';
import 'package:intra_sub_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:lottie/lottie.dart';

class BoardView extends GetView {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<KanbanResponse>(
          future: controller.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1,
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.tasks!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.tasks!.length,
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final task = snapshot.data!.tasks![index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 24,
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
                    const Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
