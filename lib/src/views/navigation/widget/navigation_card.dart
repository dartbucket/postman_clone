import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/controller/navigation_controller.dart';
import 'package:postman_clone/src/model/request_model.dart';
import 'package:postman_clone/src/providers/providers.dart';

class NavigationCard extends ConsumerWidget {
  const NavigationCard({super.key, required this.request, required this.index});

  final Request request;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final seleted = ref.watch(selectedRequestIndexProvider) == index;

    return  MaterialButton(
      elevation: 0.0,
      onPressed: () {
        ref.read(navigationControllerProvider).selectRequest(index: index);
      },
      padding: const EdgeInsets.all(20.0),
      color:  seleted ? Colors.white : Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            request.name,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            request.type.value,
            style: const TextStyle(fontSize: 12),
          ),
          InkWell(
            onTap: () {
              ref.read(navigationControllerProvider).deleteRequest(index: index);
            },
            child: const Icon(
              Icons.delete,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}