import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/core/core.dart';
import 'package:postman_clone/src/core/network.dart';
import 'package:postman_clone/src/model/request_model.dart';
import 'package:postman_clone/src/providers/providers.dart';

final requestControllerProvider = Provider((ref){
  final repo = ref.watch(networkRepoProvider);
  return RequestController(repo: repo, ref: ref);
});

class RequestController {
  final NetworkRepo _repo;
  final Ref _ref;

  RequestController({required NetworkRepo repo, required Ref ref})
      : _repo = repo,
        _ref = ref;

  void sendRequest({required String id}) async {
    final request = _ref.read(requestListProvider.select((value) {
      return value.firstWhere((element) => element.id == id);
    }));

    late final body;

    try {
      body = jsonDecode(request.body);
    } catch (e) {
      log('Body is empty');
      body = {};
    }
    _updateRequest(request.copyWith(running: true));

    late final result;

    switch (request.type) {
      case RequestType.GET:
        result = await _repo.getRequest(url: request.url);
        break;

      case RequestType.POST:
        result = await _repo.postRequest(url: request.url, body: body);
        break;

      case RequestType.PUT:
        result = await _repo.putRequest(url: request.url, body: body);
        break;

      case RequestType.DELETE:
        result = await _repo.deleteRequest(url: request.url, body: body);
        break;
    }

    result.fold(
      (Failure failure){
        _updateRequest(request.copyWith(running: false));
      },
      (response){
        _updateRequest(request.copyWith(running: false, response: response.body));
      }
    );
  }

  void updatedRequest({
    required String id,
    String? name,
    String? url,
    RequestType? type,
    String?body,
  }){
    final request = _ref.read(requestListProvider.select((value){
      return value.firstWhere((element) => element.id == id);
    }));

    _updateRequest(request.copyWith(
      name: name,
      url: url,
      type: type,
      body: body
    ));
  }

  void _updateRequest(Request updatedRequest) {
    _ref.read(requestListProvider.notifier).update((state) {
      final index =
          state.indexWhere((element) => element.id == updatedRequest.id);
      state[index] = updatedRequest;
      return [...state];
    });
  }
}
