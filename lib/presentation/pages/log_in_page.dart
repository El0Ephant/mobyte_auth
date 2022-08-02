import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:mobyte_auth/presentation/pages/homepage.dart';
import 'package:mobyte_auth/presentation/pages/page_with_logic.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobyte_auth/bloc/auth_bloc.dart';
import 'package:mobyte_auth/presentation/auth_theme.dart';
import 'package:mobyte_auth/presentation/widgets/textfields/password_text_field.dart';
import 'package:mobyte_auth/presentation/widgets/textfields/auth_text_field.dart';
import 'package:mobyte_auth/presentation/pages/sign_up_page.dart';
import 'package:mobyte_auth/presentation/pages/forgot_password_page.dart';

class LogInPage extends HookWidget {
  const LogInPage({super.key});


  void _logIn(BuildContext context, {required String login, required String password}) {
    if (login == '') {
      BlocProvider.of<AuthBloc>(context).add(const ErrorEvent(message: "Please, enter email"));
      return;
    }

    if (password == '') {
      BlocProvider.of<AuthBloc>(context).add(const ErrorEvent(message: "Please, enter password"));
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(LogInEvent(login: login, password: password));

  }

  @override
  Widget build(BuildContext context) {
    final loginController = useTextEditingController();
    final passwordController = useTextEditingController();

    return PageWithLogic(
      onPop: () async {return false;},
      onSuccess: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const HomePage()), (_)=>false);},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h),

            Image.asset("assets/mobyte_logo.png", width: 21.25.h,),

            SizedBox(height: 3.h),

            AuthTextField(hint: "Username or email", controller: loginController,),

            SizedBox(height: 3.h),

            PasswordTextField(hint: "Password", controller: passwordController),

            Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const ForgotPasswordPage()), (_)=>false);}, style: TextButton.styleFrom(foregroundColor: AuthTheme.mainColor), child: const Text("Forgot password?"))),

            ElevatedButton(onPressed: (){_logIn(context, login: loginController.text, password: passwordController.text);}, style: AuthTheme.lightButtonStyle, child: const Text("Login")),

            SizedBox(
              height: 6.25.h,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const SignUpPage()), (_)=>false);}, style: TextButton.styleFrom(foregroundColor: AuthTheme.mainColor), child: const Text("Sign up"))
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 6.25.h,
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1, color: AuthTheme.textColor,)),
                    SizedBox(width: 8.w, child: Align(alignment: Alignment.center,child: Text("or", style: AuthTheme.lightText),)),
                    const Expanded(child: Divider(thickness: 1, color: AuthTheme.textColor,)),
                  ],
                ),
              ),
            ),

            ElevatedButton(onPressed: (){BlocProvider.of<AuthBloc>(context).add(const GoogleLogInEvent());}, style: AuthTheme.lightButtonStyle, child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset("assets/google_logo.svg"),
                const Spacer(),
                const Text("Sign in with Google"),
                const Spacer(),
              ],
            )),

            SizedBox(height: 3.h),

            Platform.isIOS ?
            ElevatedButton(onPressed: (){}, style: AuthTheme.lightButtonStyle, child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset("assets/apple_logo.svg"),
                const Spacer(),
                const Text("Sign in with Apple"),
                const Spacer(),
              ],
            ))
            :
            const Center(),
          ],
        ),
      ),
      );
  }
}


