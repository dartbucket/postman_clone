import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:postman_clone/src/core/failure.dart';
import 'package:postman_clone/src/core/type_def.dart';
import 'package:postman_clone/src/res/labels.dart';

final networkRepoProvider = Provider((ref) => NetworkRepo());


class NetworkRepo {
  
  FutureEither<Response> getRequest({
    required String url,
  }) async {
     final uri = Uri.parse(url);
     log(url, name: Labels.netWorkRepo);
     try {
      final result = await get(uri);
      log(Results.requestSuccess, name: Labels.netWorkRepo);
      log(result.body, name: Labels.netWorkRepo);
      return Right(result);
     } catch (e, stktrc) {
      log(Results.requestFailed, name: Labels.netWorkRepo);
      return Left(Failure(message: Results.requestFailed, stackTrace: stktrc));
     }
  }


  FutureEither<Response> postRequest({
    required String url,
    dynamic body,
  }) async {
     final uri = Uri.parse(url);
     log(url, name: Labels.netWorkRepo);
     try {
      final result = await post(uri, body: body);
      log(Results.requestSuccess, name: Labels.netWorkRepo);
      log(result.body, name: Labels.netWorkRepo);
      return Right(result);
     } catch (e, stktrc) {
      log(Results.requestFailed, name: Labels.netWorkRepo);
      return Left(Failure(message: Results.requestFailed, stackTrace: stktrc));
     }
  }

  FutureEither<Response> putRequest({
    required String url,
    dynamic body,
  }) async {
     final uri = Uri.parse(url);
     log(url, name: Labels.netWorkRepo);
     try {
      final result = await put(uri, body: body);
      log(Results.requestSuccess, name: Labels.netWorkRepo);
      log(result.body, name: Labels.netWorkRepo);
      return Right(result);
     } catch (e, stktrc) {
      log(Results.requestFailed, name: Labels.netWorkRepo);
      return Left(Failure(message: Results.requestFailed, stackTrace: stktrc));
     }
  }

  FutureEither<Response> deleteRequest({
    required String url,
    dynamic body,
  }) async {
     final uri = Uri.parse(url);
     log(url, name: Labels.netWorkRepo);
     try {
      final result = await delete(uri, body: body);
      log(Results.requestSuccess, name: Labels.netWorkRepo);
      log(result.body, name: Labels.netWorkRepo);
      return Right(result);
     } catch (e, stktrc) {
      log(Results.requestFailed, name: Labels.netWorkRepo);
      return Left(Failure(message: Results.requestFailed, stackTrace: stktrc));
     }
  }
}