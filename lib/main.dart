import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/chat_page.dart';
import 'package:messenger/core/theme.dart';
import 'package:messenger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:messenger/features/auth/domain/usecases/login_use_case.dart';
import 'package:messenger/features/auth/domain/usecases/register_use_case.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messenger/features/auth/presentation/pages/login_page.dart';
import 'package:messenger/message_part.dart';
import 'package:messenger/features/auth/presentation/pages/register_page.dart';

void main() {
  final authRepository = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  runApp( MyApp(authRepository: authRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  const MyApp({super.key, required this.authRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
      ],
      


      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
      
        home: LoginPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register': (_) => RegisterPage(),
          '/chatPage': (_) => ChatPage(), 
        },
      ),
    );
  }
}
