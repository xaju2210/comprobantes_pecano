import 'package:examen_pecano/controllers/ControllerBase.dart';
import 'package:examen_pecano/helpers/dio/ResponseDio.dart';
import 'package:examen_pecano/models/Comprobante.dart';
import 'package:examen_pecano/repository/ComprobanteRepository.dart' as repo;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ComprobanteController extends ControllerBase {
  late List<Map<String, dynamic>> comprobantes;
  late List<Map<String, dynamic>> _comprobantesTmp;
  late bool isFilter;
  int? tipoFilter;
  DateTime? fechaFilter;

  ComprobanteController() {
    this.comprobantes = [];
    this._comprobantesTmp = [];
    this.isFilter = false;
  }

  void onPressedIniciar() async {
    await _onPressedIniciar();
  }

  Future _onPressedIniciar() async {
    await loadComprobantes();
  }

  void onTapReload() {
    isFilter = false;
    comprobantes = [..._comprobantesTmp];
    setState(() {});
  }

  String? validatorTipo(String? value) {
    if (value!.isEmpty) return "Ingrese Tipo";

    if (int.tryParse(value) == null) return "Numero invalido";
  }

  String? validatorFecha(String? value) {
    if (value!.isEmpty) return "Ingrese Fecha";
    List<String> fecha = value.split("/");
    int dia = int.parse(fecha[0]);
    int mes = int.parse(fecha[1]);

    if (dia < 0 || dia > 31) return "Fecha invalida";
    if (mes < 0 || mes > 12) return "Fecha invalida";

    try {
      DateFormat("dd/MM/yyyy").parse(value);
    } catch (e) {
      return "Fecha invalida";
    }
  }

  void onSavedTipo(String? value) {
    try {
      tipoFilter = int.parse(value ?? "0");
    } catch (e) {
      showError("Tipo no valido");
    }
  }

  void onSavedFecha(String? value) {
    try {
      fechaFilter = DateFormat('dd/MM/yyyy').parse(value ?? "");
    } catch (e) {
      showError("Fecha no valido");
    }
  }

  void onPressedOrdenar() => orderByEmision();

  void onPressFilter() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    filterByDocAndDate(tipoFilter!, fechaFilter!);
    Navigator.of(scaffoldKey.currentContext!).pop();
  }

  Future loadComprobantes() async {
    showLoading();
    await repo.getComprobantes().then(_loadComprobantes);
    Navigator.of(scaffoldKey.currentContext!).pop();
  }

  void _loadComprobantes(ResponseDio r) {
    try {
      bool isValidateResponse = validateResponse(r);
      if (!isValidateResponse) return;

      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(r.data);
      comprobantes = data.map((e) => Comprobante.fromJson(e).toJson()).toList();

      setState(() {});
    } catch (e) {
      showError(e.toString());
      print(e.toString());
    }
  }

  void filterByDocAndDate(int tipoDocumento, DateTime fechaEmision) {
    _comprobantesTmp = [...comprobantes];

    DateTime dtmFechaInicio =
        new DateTime(fechaEmision.year, fechaEmision.month, fechaEmision.day);
    DateTime dtmFechaFin =
        dtmFechaInicio.add(Duration(days: 1, milliseconds: -1));
    comprobantes
        .removeWhere((e) => e['tipoDocumento'] != tipoDocumento.toString());
    setState(() {});
    comprobantes.removeWhere((e) =>
        dtmFechaInicio
            .difference(DateFormat('dd/MM/yyyy').parse(e['fechaEmision']))
            .inMicroseconds >
        0);
    setState(() {});
    comprobantes.removeWhere((e) =>
        dtmFechaFin
            .difference(DateFormat('dd/MM/yyyy').parse(e['fechaEmision']))
            .inMicroseconds <
        0);
    isFilter = true;

    print(comprobantes.length);
    setState(() {});
  }

  void orderByEmision() {
    if (comprobantes.length == 0) return showError("Sin datos para ordenar");

    comprobantes.sort((a, b) => DateFormat('dd/MM/yyyy')
        .parse(b['fechaEmision'])
        .compareTo(DateFormat('dd/MM/yyyy').parse(a['fechaEmision'])));
    setState(() {});
  }
}
