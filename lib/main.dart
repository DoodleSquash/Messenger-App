import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:messenger/features/chat/data/repositories/message_repository_impl.dart';
import 'package:messenger/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:messenger/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:messenger/features/chat/presentation/pages/chat_page.dart';
import 'package:messenger/core/theme.dart';
import 'package:messenger/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:messenger/features/auth/domain/usecases/login_use_case.dart';
import 'package:messenger/features/auth/domain/usecases/register_use_case.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messenger/features/auth/presentation/pages/login_page.dart';

import 'package:messenger/features/auth/presentation/pages/register_page.dart';
import 'package:messenger/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:messenger/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:messenger/features/conversation/domain/repositories/conversations_repository.dart';
import 'package:messenger/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:messenger/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:messenger/features/conversation/presentation/pages/conversations_page.dart';

void main() {
  final authRepository =AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepository = ConversationsRepositoryImpl(conversationRemoteDataSource: ConversationRemoteDataSource());
  final messagesRepository = MessagesRepositoryImpl( remoteDataSource: MessagesRemoteDataSource());
  runApp(MyApp(
    authRepository: authRepository,
    conversationsRepository: conversationsRepository,
     messagesRepository: messagesRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;
  final MessagesRepositoryImpl messagesRepository;

  const MyApp(
      {super.key,
      required this.authRepository,
      required this.conversationsRepository,
       required this.messagesRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
            fetchConversationsUseCase:
                FetchConversationsUseCase(conversationsRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ChatBloc(
            fetchMessagesUseCase: FetchMessagesUseCase(conversationsRepository,
                messagesRepository: messagesRepository),
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
          '/conversationsPage': (_) => ConversationsPage(),
        },
      ),
    );
  }
}
