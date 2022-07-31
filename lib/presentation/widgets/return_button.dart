import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:mobyte_auth/presentation/auth_theme.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top ,),
          RawMaterialButton(
            onPressed: () {Navigator.of(context).maybePop();},
            fillColor: AuthTheme.mainColor.withOpacity(0.5),
            shape: const CircleBorder(),
            child: SizedBox(height: 12.w, child: const Icon(Icons.arrow_back_outlined, color: AuthTheme.backColor,)),
          ),
        ],
      ),
    );
  }
}
