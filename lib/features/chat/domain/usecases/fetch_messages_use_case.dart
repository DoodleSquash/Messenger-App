import 'package:messenger/features/chat/domain/entities/message_entity.dart';
import 'package:messenger/features/chat/domain/repositories/message_repository.dart';
import 'package:messenger/features/conversation/data/repositories/conversations_repository_impl.dart';

class FetchMessagesUseCase {
  final MessagesRepository messagesRepository;

  FetchMessagesUseCase(ConversationsRepositoryImpl conversationsRepository,
      {required this.messagesRepository});

  Future<List<MessageEntity>> call(String conversationId) async {
    final messages = await messagesRepository.fetchMessages(conversationId);
    return messages;
  }
}
