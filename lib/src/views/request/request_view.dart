import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/controller/request_controller.dart';
import 'package:postman_clone/src/model/request_model.dart';
import 'package:postman_clone/src/providers/providers.dart';
import 'package:postman_clone/src/views/request/widgets/paramaters.dart';
import 'package:postman_clone/src/views/request/widgets/response.dart';
import 'package:highlight/languages/json.dart' show json;

class RequestView extends ConsumerStatefulWidget {
  const RequestView({super.key, required this.id});

  final String id;

  @override
  ConsumerState<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends ConsumerState<RequestView> {

  late final CodeController bodyController;

  @override
  void initState() {
    super.initState();
    final request = ref.read(requestListProvider.select((value){
      return value.firstWhere((element) => element.id == widget.id);
    }));

    bodyController = CodeController(
      text: request.body,
      language: json,
    );
  }
  @override
  Widget build(BuildContext context) {

    final request = ref.watch(requestListProvider.select((value){
      return value.firstWhere((element) => element.id == widget.id);
    }));

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 20),
            initialValue: request.name,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              ref.read(requestControllerProvider).updatedRequest(id: widget.id, name: value);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey.shade300),
                child: DropdownButton(
                  underline: const SizedBox.shrink(),
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
                  value: request.type,
                  items: RequestType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.value),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    ref.read(requestControllerProvider).updatedRequest(id: widget.id, type: value);
                  },
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: TextFormField(
                  initialValue: request.url,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    ref.read(requestControllerProvider).updatedRequest(id: widget.id, url: value);
                  },
                ),
              ),
              MaterialButton(
                padding: const EdgeInsets.all(25.0),
                color: Colors.blue,
                onPressed: () {
                  ref.read(requestControllerProvider).sendRequest(id: widget.id);
                },
                child: const Text(
                  "SEND",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          request.running ? const LinearProgressIndicator() : const SizedBox.shrink(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: ParametersView(
                      onChanged: (value){
                        ref.read(requestControllerProvider).updatedRequest(id: widget.id, body: value);
                      },
                      body: request.body,
                      controller: bodyController,
                )),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    child: ResponseView(
                      response: request.response,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
