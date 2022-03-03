import 'package:examen_pecano/controllers/ComprobantesController.dart';
import 'package:examen_pecano/widgets/TextFormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ComprobanteView extends StatefulWidget {
  @override
  _ComprobanteViewState createState() => _ComprobanteViewState();
}

class _ComprobanteViewState extends StateMVC<ComprobanteView> {
  ComprobanteController _con = ComprobanteController();

  _ComprobanteViewState() : super(ComprobanteController()) {
    _con = controller as ComprobanteController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: _body(),
      appBar: _appbar(),
    );
  }

  PreferredSizeWidget _appbar() => AppBar(
        title: Text("Comprobantes(${_con.comprobantes.length})"),
        actions: [
          if (_con.isFilter)
            InkWell(onTap: _con.onTapReload, child: Icon(Icons.sync)),
          const SizedBox(
            width: 10,
          )
        ],
      );

  Widget _body() => Column(children: [
        Expanded(
          child: _list(),
        ),
        _buttons(),
      ]);

  Widget _list() => ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: List.generate(_con.comprobantes.length, _listGenerate));

  Widget _listGenerate(int index) => ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("RAZON SOCIAL: " +
                (_con.comprobantes[index]['razonSocial'] ?? "")),
            SizedBox(height: 5),
            Text("TIPO DOCUMENTO: " +
                (_con.comprobantes[index]["tipoDocumento"] ?? "")),
            SizedBox(height: 5),
            Text("NÚMERO DOCUMENTO: " +
                (_con.comprobantes[index]["nroDocumento"] ?? "")),
            SizedBox(height: 5),
            Text("IMPORTE TOTAL: " +
                (_con.comprobantes[index]["importe"] ?? "")),
            SizedBox(height: 5),
            Text("FECHA EMISION: " +
                (_con.comprobantes[index]["fechaEmision"] ?? "")),
            Divider(),
          ],
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_sharp,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      );

  Widget _buttons() => Row(children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _con.onPressedIniciar,
            child: Text("INICIAR"),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder: _formFilter);
            },
            child: Text("AGRUPAR"),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: _con.onPressedOrdenar,
            child: Text("ORDENAR"),
          ),
        ),
      ]);

  Widget _formFilter(BuildContext context) => AlertDialog(
        content: Form(
            key: _con.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ingrese tipo"),
                TextFormFieldWidget(
                    keyboardType: TextInputType.number,
                    validator: _con.validatorTipo,
                    onSaved: _con.onSavedTipo),
                Text("Ingrese fecha(dd/MM/yyyy)"),
                TextFormFieldWidget(
                    keyboardType: TextInputType.datetime,
                    validator: _con.validatorFecha,
                    onSaved: _con.onSavedFecha),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          label: Text("Atras")),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                          icon: Icon(Icons.save),
                          onPressed: _con.onPressFilter,
                          label: Text("Filtrar")),
                    ),
                  ],
                )
              ],
            )),
      );
}
