import 'package:dartz/dartz.dart';
import 'package:marvel_app/app/models/failure.dart';

abstract class MarvelHttp {
  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, dynamic>> get(
    String url, {
    bool setAuthToken = true,
    void Function(int, int)? onReceiveProgress,
  });

  Future<Either<Failure, dynamic>> patch(
    String url, {
    required Map<String, dynamic> data,
  });
}
