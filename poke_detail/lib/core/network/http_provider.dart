import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_detail/core/network/api_response.dart';

@lazySingleton
class HttpProvider {
  final Dio _dio;

  HttpProvider(this._dio);

  Future<Response> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url, options: Options(headers: headers));
      return _validateResponse(response);
    } on DioException catch (e) {
      final errorMessage = e.response?.data as String?;
      throw ServerResponse.error(errorMessage ?? e.message!);
    } catch (e) {
      rethrow;
    }
  }

  Response _validateResponse(Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
        return response;
      default:
        throw ServerResponse.error(response.data as String);
    }
  }
}
