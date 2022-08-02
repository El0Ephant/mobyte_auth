import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobyte_auth/presentation/pages/verification_page.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobyte_auth/bloc/auth_bloc.dart';
import 'package:mobyte_auth/presentation/auth_theme.dart';
import 'package:mobyte_auth/presentation/widgets/return_button.dart';
import 'package:mobyte_auth/presentation/widgets/textfields/auth_text_field.dart';
import 'package:mobyte_auth/presentation/pages/page_with_logic.dart';

import 'package:mobyte_auth/presentation/pages/log_in_page.dart';

class ForgotPasswordPage extends HookWidget {
  const ForgotPasswordPage({super.key});

  void _sendReset(BuildContext context, {required String login}) {

    if (login == '') {
      BlocProvider.of<AuthBloc>(context).add(const ErrorEvent(message: "Please, enter username or password"));
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(SendResetEvent(login: login));

  }

  @override
  Widget build(BuildContext context) {
    final loginController = useTextEditingController();

    return PageWithLogic(
      onSuccess:  () async {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const VerificationPage(),), (route) => false);},
      onPop: () async {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const LogInPage()), (route) => false); return false;},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ReturnButton(),
              SizedBox(height: 10.h,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                        child: Text("Forgot Your Password?", style: AuthTheme.headerText)
                    ),
                    Text("No worries, you just need to type your email or username and we will send the verification code", style: AuthTheme.bodyText),
                  ],
                ),
              ),


              SizedBox(height: 4.h),

              AuthTextField(hint: "Email or username", controller: loginController,),

              SizedBox(height: 4.h),

              ElevatedButton(onPressed: (){_sendReset(context, login: loginController.text);}, style: AuthTheme.darkButtonStyle, child: const Text("Reset my password")),

              SizedBox(height: 20.h,),
            ]
        ),
      ),
    );
  }
}

