import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobyte_auth/bloc/auth_bloc.dart';
import 'package:mobyte_auth/presentation/widgets/return_button.dart';
import 'package:mobyte_auth/presentation/auth_theme.dart';
import 'package:mobyte_auth/presentation/pages/page_with_logic.dart';

import 'package:mobyte_auth/presentation/pages/log_in_page.dart';

class VerificationPage extends HookWidget {
  const VerificationPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final pinController = useTextEditingController();

    return PageWithLogic(
      onSuccess: (){},
      onPop: () async {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>LogInPage()), (route) => false); return false;},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ReturnButton(),
              const Spacer(flex: 1),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Enter Verification Code", style: AuthTheme.headerText)
                    ),
                    Text("Enter code that we have sent to your email $email", style: AuthTheme.bodyText),
                  ],
                ),
              ),


              SizedBox(height: 4.h),

              PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: pinController,
                  onChanged: (s){},
                  keyboardType: TextInputType.number,
                  obscureText: true,

                  pinTheme: PinTheme(
                    activeColor: AuthTheme.textColor,
                    selectedColor: AuthTheme.mainColor,
                    inactiveColor: AuthTheme.textColor.withOpacity(0.5),

                    fieldHeight: 8.h,
                    fieldWidth: 8.h,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                  ),
              ),

              SizedBox(height: 4.h),

              ElevatedButton(onPressed: (){}, style: AuthTheme.darkButtonStyle, child: const Text("Reset my password")),

              TextButton(onPressed: (){}, style: TextButton.styleFrom(foregroundColor: AuthTheme.mainColor), child: const Text("Resend code")),
              const Spacer(flex: 2),
            ]
        ),
      ),
    );
  }
}
