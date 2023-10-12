import 'package:fpdart/fpdart.dart';
import 'package:postman_clone/src/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = Future<Either<Failure,void>>;
typedef FutureVoid = Future<void>;