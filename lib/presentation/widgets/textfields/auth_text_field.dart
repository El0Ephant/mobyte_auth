import 'package:flutter/material.dart';

import 'package:mobyte_auth/presentation/widgets/textfields/text_field_design_mixin.dart';

class AuthTextField extends StatelessWidget with TextFieldDesignMixin {
  const AuthTextField({super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextFieldDesignMixin.style,
      decoration: TextFieldDesignMixin.decoration.copyWith(hintText: hint),
      controller: controller,
    );
  }

}