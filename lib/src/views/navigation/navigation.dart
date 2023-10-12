import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/controller/navigation_controller.dart';
import 'package:postman_clone/src/providers/providers.dart';
import 'package:postman_clone/src/views/navigation/widget/navigation_card.dart';

class NavigationPanel extends ConsumerWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openRequests = ref.watch(requestListProvider);

    return SizedBox(
      width: 200,
      child: Container(
        color: Colors.blue.shade100,
        child: Column(
          children: [
            MaterialButton(
              padding: const EdgeInsets.all(20.0),
              color: Colors.blue.shade400,
              onPressed: () {
                ref.read(navigationControllerProvider).addNewRequest();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("New Tab"),
                  Icon(Icons.add),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: openRequests.length,
                  itemBuilder: (context, index) {
                    return NavigationCard(
                      request: openRequests[index],
                      index: index,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
