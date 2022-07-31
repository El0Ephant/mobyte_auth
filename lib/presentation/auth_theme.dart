import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

abstract class AuthTheme {
  static final theme = ThemeData(
    scaffoldBackgroundColor: backColor,
    /*buttonTheme: const ButtonThemeData(
      buttonColor: mainColor,
    ),*/ //Не работает почему-то
    primaryColor: mainColor,
    fontFamily: 'Nunito',
  );

  static const backColor = Colors.white;
  static const lightColor = Colors.white;
  static const mainColor = Color.fromRGBO(138, 93, 165, 1);
  static const subColor = Color.fromRGBO(25, 152, 207, 1);
  static const textColor = Color.fromRGBO(27, 27, 27, 1);
  static const errorColor = Colors.red;

  static final lightText = TextStyle(color: textColor.withOpacity(0.5),
      fontWeight: FontWeight.w400,
      fontSize: 14.sp);
  static final bodyText = TextStyle(color: textColor.withOpacity(0.5),
      fontWeight: FontWeight.w600,
      fontSize: 16.sp);
  static final headerText = TextStyle(
      color: textColor, fontWeight: FontWeight.w700, fontSize: 20.sp);
  static final pinText = TextStyle(
      color: textColor, fontFamily: 'Poppins', fontSize: 24.sp);



  static final darkButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(bodyText),
    backgroundColor:  MaterialStateProperty.all<Color>(mainColor),
    foregroundColor: MaterialStateProperty.all<Color>(lightColor),
    minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(6.25.h)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
          )
      )
  );


  static final lightButtonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle>(lightText),
    backgroundColor: MaterialStateProperty.all<Color>(backColor),
    foregroundColor:  MaterialStateProperty.all<Color>(mainColor),
    minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(6.25.h)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
          )
      ),
    elevation:  MaterialStateProperty.all<double>(10),
  );


}