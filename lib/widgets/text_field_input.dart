import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  // final String;
  final TextInputType textInputType;
  final bool isPassword;
  final TextEditingController textEditingController;

  const TextFieldInput({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textEditingController,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.orange),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    );

    return TextField(
      controller: textEditingController,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        label: Text(hintText),
        labelStyle: TextStyle(color: Colors.orange),
        focusedBorder: border,
        border: border,
        contentPadding: EdgeInsets.all(10.0),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
    );
  }
}
