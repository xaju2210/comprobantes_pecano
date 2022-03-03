import 'package:intl/intl.dart';

class Comprobante {
  late String nroDocumento;
  late DateTime fechaEmision;
  late int tipoDocumento;
  late int estado;
  late String docIdentidad;
  late String razonSocial;
  late double importeTotal;
  static final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  DateFormat get foramtter => _formatter;

  Comprobante(
    String nroDocumento,
    DateTime fechaEmision,
    int tipoDocumento,
    int estado,
    String docIdentidad,
    String razonSocial,
    double importeTotal,
  ) {
    this.nroDocumento = nroDocumento;
    this.fechaEmision = fechaEmision;
    this.tipoDocumento = tipoDocumento;
    this.estado = estado;
    this.docIdentidad = docIdentidad;
    this.razonSocial = razonSocial;
    this.importeTotal = importeTotal;
  }

  Comprobante.fromJson(Map<String, dynamic> json) {
    this.nroDocumento = json['NumeroDocumento'] as String;
    this.fechaEmision = DateTime.parse(json['FechaEmision']);
    this.tipoDocumento = json['TipoDocumento'] as int;
    this.estado = json['Estado'] as int;
    this.docIdentidad = json['DocumentoIdentidadAdquiriente'] as String;
    this.razonSocial = json['RazonSocialAdquiriente'] as String;
    this.importeTotal = json['ImporteTotal'] as double;
  }

  Map<String, dynamic> toJson() => {
        "razonSocial": razonSocial,
        "tipoDocumento": tipoDocumento.toString(),
        "nroDocumento": nroDocumento.toString(),
        "estado": estado,
        "importe": importeTotal.toString(),
        "documentoIdentidad": docIdentidad,
        "fechaEmision": _formatter.format(fechaEmision),
      };
}
