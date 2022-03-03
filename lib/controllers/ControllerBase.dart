import 'package:examen_pecano/helpers/dio/ResponseDio.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// import 'package:planiweb/src/helpers/Response.dart';
// import 'package:planiweb/src/helpers/alertDialog.dart';
// import 'package:planiweb/src/helpers/peticiones.dart' as peticion;

class ControllerBase extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> formKey;
  late SnackBar snackbar;
  late bool _isSnackBarActive;

  @override
  void initState() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.formKey = new GlobalKey<FormState>();
    this._isSnackBarActive = false;
    super.initState();
  }

  bool validateResponse(ResponseDio response) {
    if (response.status == "ERROR") {
      showError(response.data);
      return false;
    }
    return true;
  }

  void showError(String message) => showSnackBar(message, true);

  void showSnackBar(String message, bool isError) {
    if (_isSnackBarActive) return;

    _isSnackBarActive = true;
    _setDataSnackBar(message, isError);

    _showSnackMessage();
  }

  // void closeSnackBar(){

  // }

  void _setDataSnackBar(String message, bool isError) {
    snackbar = SnackBar(
        backgroundColor: isError == true
            ? Colors.red[400]
            : Theme.of(scaffoldKey.currentContext!).primaryColor,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Flexible(
                  child: Text(
                message,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              )),
              //FlatButton(onPressed: () {}, child: Text("Aceptar"))
            ],
          ),
        ));
  }

  void _showSnackMessage() => ScaffoldMessenger.of(scaffoldKey.currentContext!)
      .showSnackBar(snackbar)
      .closed
      .then(_onClosedSnackBar);

  void _onClosedSnackBar(SnackBarClosedReason reason) {
    _isSnackBarActive = false;
  }

  void showLoading() => showDialog(
      context: scaffoldKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        );
      });
}
