
import 'package:messenger/features/conversation/domain/entities/conversation_entity.dart';
import 'package:messenger/features/conversation/domain/repositories/conversations_repository.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;
  
  FetchConversationsUseCase( this.repository);

  Future<List<ConversationEntity>> call() async {
   return repository.fetchConversations();
  }
}
