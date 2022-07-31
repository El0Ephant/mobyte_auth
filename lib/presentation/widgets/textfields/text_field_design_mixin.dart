import 'package:flutter/material.dart';
import 'package:mobyte_auth/presentation/auth_theme.dart';

mixin TextFieldDesignMixin {
  static final style =  AuthTheme.lightText.copyWith(color: AuthTheme.textColor);
  static final decoration = InputDecoration(
    hintText: "",
    hintStyle: AuthTheme.lightText,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 1.5,
        color: AuthTheme.textColor.withOpacity(0.5),
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1.5,
        color: AuthTheme.mainColor,
      ),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1.5,
        color: AuthTheme.errorColor,
      ),
    ),


  );
}