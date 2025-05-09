import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/socket_service.dart';
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
import 'package:messenger/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:messenger/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:messenger/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:messenger/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:messenger/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:messenger/features/conversation/domain/repositories/conversations_repository.dart';
import 'package:messenger/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:messenger/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:messenger/features/conversation/presentation/pages/conversations_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final  socketService = SocketService();
  await socketService.initSocket();

  final authRepository =AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepository = ConversationsRepositoryImpl(conversationRemoteDataSource: ConversationRemoteDataSource());
  final messagesRepository = MessagesRepositoryImpl( remoteDataSource: MessagesRemoteDataSource());
  final contactsRepository = ContactsRepositoryImpl(remoteDataSource: ContactsRemoteDataSource());
  
  
  runApp(MyApp(
    authRepository: authRepository,
    conversationsRepository: conversationsRepository,
     messagesRepository: messagesRepository,
    contactsRepository: contactsRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;
  final MessagesRepositoryImpl messagesRepository;
  final ContactsRepositoryImpl contactsRepository;

  const MyApp(
      {super.key,
      required this.authRepository,
      required this.conversationsRepository,
       required this.messagesRepository,
       required this.contactsRepository});

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
         BlocProvider(
          create: (_) => ContactsBloc(
           fetchContactsUsecase:  FetchContactsUseCase(contactsRepository: contactsRepository),
           addContactUseCase: AddContactUseCase(contactsRepository: contactsRepository),
            
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
