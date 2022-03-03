import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final bool? obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? inputBorder;
  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  TextFormFieldWidget(
      {Key? key,
      this.contentPadding,
      this.obscureText,
      this.hintText,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.inputBorder,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _obscureText;
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    _obscureText = widget.obscureText ?? false;
    super.initState();
  }

  void clickPassword() {
    myFocusNode.requestFocus();
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            isDense: true,
            contentPadding: widget.contentPadding ?? EdgeInsets.all(10),
            fillColor: Colors.white,
            filled: true,
            // errorText: widget.errorMessageAuth,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon ??
                (widget.obscureText == null
                    ? null
                    : IconButton(
                        splashColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        icon: Icon((_obscureText)
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: clickPassword,
                        splashRadius: 15,
                        tooltip:
                            (_obscureText) ? 'Mostrar Clave' : 'Ocultar Clave',
                      )),
            prefixIcon: widget.prefixIcon,
            //hoverColor: Colors.black,
            border: widget.inputBorder ?? OutlineInputBorder()),
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        onSaved: widget.onSaved,
      ),
    );
  }
}
