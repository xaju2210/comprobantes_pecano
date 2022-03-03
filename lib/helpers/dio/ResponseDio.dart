class ResponseDio {
  String? status;
  String? dioError;
  dynamic data;

  ResponseDio(String status, dynamic data, {String dioError = ""}) {
    this.status = status;
    this.data = data;
    this.dioError = dioError;
  }

  Map toMap() => {"status": status, "data": data, "dioError": dioError};
}
