import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postman_clone/src/model/request_model.dart';

final selectedRequestIndexProvider = StateProvider((ref) => -1);

final requestListProvider = StateProvider<List<Request>>((ref) => []);