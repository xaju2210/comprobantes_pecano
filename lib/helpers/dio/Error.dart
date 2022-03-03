class Error {
  late String mensajeError;
  late String detalle;

  Error({String? mensajeError, String? detalle}) {
    this.mensajeError = mensajeError ?? "";
    this.detalle = detalle ?? "";
  }

  Map<String, dynamic> toJson() =>
      {"mensajeError": mensajeError, "detalle": detalle};
}
