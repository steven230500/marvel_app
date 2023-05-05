import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marvel_app/app/config/config.dart';
import 'package:marvel_app/app/helpers/preferences.dart';
import 'package:marvel_app/app/http/client.dart';
import 'package:marvel_app/app/models/failure.dart';
import 'dart:io';

import 'interceptors.dart';

class MarvelDioHttpClient extends MarvelHttp {
  MarvelDioHttpClient({
    required AppConfig appConfig,
    required MarvelPreferences preferences,
  }) : _preferences = preferences {
    _dioIntance = _getDioAppConfig(appConfig);
  }

  late Dio _dioIntance;
  final MarvelPreferences _preferences;

  @override
  Future<Either<Failure, Map<String, dynamic>>> post(
    String url, {
    required Map<String, dynamic> data,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      _setToken();
      final response = await _dioIntance.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      final statusErr = _validateStatus(response);
      if (statusErr != null) return left(Failure(statusErr));
      return right(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return left(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return left(Failure(errorMsg));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> put(
    String url, {
    required Map<String, dynamic> data,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dioIntance.put(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      final statusErr = _validateStatus(response);
      if (statusErr != null) return left(Failure(statusErr));
      return right(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return left(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return left(Failure(errorMsg));
    }
  }

  @override
  Future<Either<Failure, dynamic>> get(
    String url, {
    bool setAuthToken = true,
    void Function(int, int)? onReceiveProgress,
  }) async {
    if (setAuthToken) await _setToken();
    return _dioIntance
        .get(
      url,
      onReceiveProgress: onReceiveProgress,
    )
        .then(
      (value) {
        return right(value.data);
      },
      onError: (dynamic err) {
        final errorMsg = _getErrorMessage(err);
        return left(Failure(errorMsg));
      },
    );
  }

  @override
  Future<Either<Failure, dynamic>> patch(
    String url, {
    required Map<String, dynamic> data,
  }) async {
    return _dioIntance.patch(url, data: data).then(
      (Response<dynamic> response) {
        final statusErr = _validateStatus(response);
        if (statusErr != null) return left(Failure(statusErr));
        return right(response.data);
      },
      onError: (err) {
        final dioFailure = _validateDioError(err);
        if (dioFailure != null) return left(dioFailure);
        final errorMsg = _getErrorMessage(err);
        return left(Failure(errorMsg));
      },
    );
  }

  String _getErrorMessage(dynamic data) {
    if (data == null) {
      return 'Error en la petición';
    }

    if (data is Map<String, dynamic> && data['message'] != null) {
      return _splitErrMsg(
        data['message'] ?? 'Error en la petición',
      );
    }

    if (data is String) {
      return data;
    }
    if (data is DioError) {
      if (data.response != null && data.response!.data['message'] != null) {
        return _splitErrMsg(
          data.response!.data['message'] ?? 'Error en la petición',
        );
      }
      return data.message ?? '';
    }

    return 'Error en la petición';
  }

  String _splitErrMsg(String respData) {
    final splitMsg = respData.split(':');
    if (splitMsg.length > 1) {
      return splitMsg[0];
    } else {
      return respData;
    }
  }

  String? _validateStatus(Response<dynamic> response) {
    if (response.statusCode == null) {
      return 'Invalid response status';
    }

    if (response.statusCode != 200 && response.statusCode != 202 && response.statusCode != 201) {
      return _getErrorMessage(response.data);
    }

    if (response.statusCode == 400) {
      return 'Los datos enviados no son validos, revise de nuevo o contacte'
          ' a soporte';
    }

    return null;
  }

  Failure? _validateDioError(dynamic err) {
    if (err is DioError && err.response != null) {
      if (err.response!.statusCode == null) {
        return const Failure('Invalid response status');
      }

      if (err.response!.statusCode == 400) {
        return const Failure('Los datos enviados no son validos, revise '
            'de nuevo o contacte a soporte');
      }
    }

    return null;
  }

  Future<void> _setToken() async {
    final token = _preferences.authToken;
    if (token.isNotEmpty) {
      _dioIntance.options.headers.addAll({'Authorization': 'Bearer $token'});
    }
  }

  Dio _getDioAppConfig(AppConfig appConfig) {
    final dioInstance = Dio()
      ..options.connectTimeout = const Duration(seconds: 9000000)
      ..options.receiveTimeout = const Duration(seconds: 9000000)
      ..options.headers = {
        Headers.contentTypeHeader: Headers.jsonContentType,
        Headers.acceptHeader: Headers.jsonContentType,
        HttpHeaders.acceptEncodingHeader: 'gzip',
        'App-name': appConfig.appName,
        'App-version': appConfig.appVersion,
      }
      ..interceptors.add(GuardInterceptor())
      ..options.baseUrl = appConfig.baseUrl;

    if (appConfig.env == AppEnv.test) {
      dioInstance.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dioInstance;
  }
}
