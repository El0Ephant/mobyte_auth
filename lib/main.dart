import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobyte_auth/bloc/auth_bloc.dart';
import 'package:mobyte_auth/presentation/auth_theme.dart';
import 'package:mobyte_auth/presentation/pages/log_in_page.dart';
import 'package:mobyte_auth/data/auth_repository.dart';

import 'package:mobyte_auth/data/firebase_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      lazy: false,
      create: (context) => FirebaseRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        child: Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                title: 'Mobyte auth',
                theme: AuthTheme.theme,
                home: LogInPage(),
              );
            }
        ),
      ),
    );
  }
}
