import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/model/request_model.dart';
import 'package:postman_clone/src/providers/providers.dart';

final navigationControllerProvider = Provider((ref) => NavigationController(ref: ref));

class NavigationController {
  final Ref _ref;
  
  NavigationController({
    required Ref ref
  }): _ref = ref;

  void addNewRequest(){
    _ref.read(requestListProvider.notifier).update((state){
      final newRequest = Request();
      return [newRequest, ...state];
    });

    _ref.read(selectedRequestIndexProvider.notifier).update((state){

      final requestList = _ref.read(requestListProvider);
      if(state == -1){
        return 0;
      }
      return requestList.length -1;
    });
  }

  void deleteRequest({
    required int index
  }){
    _ref.read(requestListProvider.notifier).update((state){
      if(state.isEmpty){
        return state;
      }

      if(state.length-1 >= index){
        state.removeAt(index);
        _ref.read(selectedRequestIndexProvider.notifier).update((state) => index-1);

        return [...state];
      }
      return state;
    });
  }

  void selectRequest({
    required int index
  }){
    _ref.read(selectedRequestIndexProvider.notifier).update((state) => index);
  }
}