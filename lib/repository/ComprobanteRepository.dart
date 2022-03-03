import 'package:dio/dio.dart';
import 'package:examen_pecano/helpers/dio/RequestDio.dart';
import 'package:examen_pecano/helpers/dio/ResponseDio.dart';

Future<ResponseDio> getComprobantes() async {
  RequestDio dio = new RequestDio();

  ResponseDio r = await dio.get("api/Comprobante");

  return r;
}
