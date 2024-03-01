import 'package:dartz/dartz.dart';
import 'package:demo_login_ui/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Faliure, T>>;

typedef ResultVoid = ResultFuture<void>;

typedef ResultStream = ResultFuture<Stream>;

typedef DataMap = Map<String, dynamic>;
