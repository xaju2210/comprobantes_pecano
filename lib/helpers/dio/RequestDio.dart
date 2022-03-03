import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:examen_pecano/helpers/dio/Error.dart';
import 'package:examen_pecano/helpers/dio/ResponseDio.dart';
import 'package:global_configuration/global_configuration.dart';

class RequestDio {
  late Dio _dio;
  late BaseOptions _options;

  RequestDio({int? connectTimeout}) {
    _options = BaseOptions(
      baseUrl: GlobalConfiguration().getValue("api_base"),
      connectTimeout: connectTimeout ?? 10 * 1000,
      contentType: 'application/json; charset=utf-8',
      validateStatus: (status) => status! < 500,
    );

    _dio = new Dio(_options);
  }

  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: _onResponse,
      onError: _onError,
    ));
  }

  void _onResponse(Response<dynamic> r, ResponseInterceptorHandler handler) {
    r.data = ResponseDio("OK", r.data);
    return handler.next(r);
  }

  void _onError(DioError err, ErrorInterceptorHandler handler) {
    Response<dynamic> r = new Response(
      requestOptions: RequestOptions(path: ""),
    );

    r.data = ResponseDio(
      "ERROR",
      Error(
        mensajeError: err.message,
        detalle: err.stackTrace.toString(),
      ).toJson(),
    );

    return handler.resolve(r);
  }

  Future<ResponseDio> post(String url, {Map<String, dynamic>? body}) async {
    _initInterceptors();
    var response = await _dio.post(url, data: body);

    return ResponseDio(response.data['status'], response.data['data']);
  }

  Future<ResponseDio> get(String url) async {
    _initInterceptors();
    var response = await _dio.get(url);
    return response.data;
  }
}
