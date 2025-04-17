// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messenger/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:messenger/features/conversation/data/repositories/conversations_repository_impl.dart';

import 'package:messenger/main.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:messenger/features/auth/data/datasources/auth_remote_data_source.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a fake auth repository
    final authRepository = AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSource(),
    );

    final conversationsRepository = ConversationsRepositoryImpl(
      conversationRemoteDataSource: ConversationRemoteDataSource(),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(authRepository: authRepository, conversationsRepository:conversationsRepository,));

    // Since this is not a counter app, remove the old test code
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Login'), findsOneWidget); // Adjust this to something in your LoginPage
  });
}

