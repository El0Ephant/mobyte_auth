import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mobyte_auth/presentation/widgets/textfields/text_field_design_mixin.dart';

class PasswordTextField extends StatefulWidget with TextFieldDesignMixin {
  PasswordTextField({super.key, required this.hint, required this.controller, bool Function(String s)? pred, this.message}) {


    if (pred != null) {
      validator = (s){return s != null && pred(s);};
    }
    else {
      validator = (s){return s != null;};
    }
  }

  final String hint;
  final TextEditingController controller;
  late final bool Function(String? s) validator;
  final String? message;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextFieldDesignMixin.style,
      decoration: TextFieldDesignMixin.decoration.copyWith(hintText: widget.hint, suffixIcon: IconButton(
        onPressed: (){setState(() {
          hidden = !hidden;
        });},
        icon: SvgPicture.asset("assets/eye.svg"),
      )),
      controller: widget.controller,
      obscureText: hidden,
      validator: (s)=> widget.validator(s) ? null : widget.message,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}