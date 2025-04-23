import 'package:messenger/features/chat/data/datasources/messages_remote_data_source.dart';
import 'package:messenger/features/chat/domain/entities/message_entity.dart';
import 'package:messenger/features/chat/domain/repositories/message_repository.dart';
import 'package:messenger/features/conversation/data/datasources/conversation_remote_data_source.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;

  MessagesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    final messages = await remoteDataSource.fetchMessages(conversationId);
    return messages;
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    throw UnimplementedError();
  }
}
