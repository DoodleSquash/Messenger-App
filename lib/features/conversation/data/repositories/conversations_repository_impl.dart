import 'package:messenger/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:messenger/features/conversation/domain/entities/conversation_entity.dart';
import 'package:messenger/features/conversation/domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationRemoteDataSource conversationRemoteDataSource;

  ConversationsRepositoryImpl({required this.conversationRemoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversations() async {
    return await conversationRemoteDataSource.fetchConverstaions();
  }
}
