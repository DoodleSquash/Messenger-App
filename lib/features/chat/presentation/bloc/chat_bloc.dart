import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:messenger/core/socket_service.dart';
import 'package:messenger/features/chat/domain/entities/message_entity.dart';
import 'package:messenger/features/chat/domain/usecases/fetch_messages_use_case.dart';
import 'package:messenger/features/chat/presentation/bloc/chat_event.dart';
import 'package:messenger/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessagesUseCase fetchMessagesUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessagesUseCase}) : super(ChatLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessages);
    on<ReceiveMessageEvent>(_onReceiveMessages);
  }


  
  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      final messages = await fetchMessagesUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(ChatLoadedState(List.from(_messages)));

      _socketService.socket.emit('joinConversation', event.conversationId);
      _socketService.socket.on('newMessage', (data) {
        print("step1 - recive:$data");
        add(ReceiveMessageEvent(data));
      });
    } catch (e) {
      emit(ChatErrorState('Failed to load messages'));
    }
  }




  Future<void> _onSendMessages(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    String userId = await _storage.read(key: 'userId') ?? "";

    final newMessage = {
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId,
    };

    // Emit the message to the server
    _socketService.socket.emit('sendMessage', newMessage);

    // // Add the new message to the local list
    // final messageEntity = MessageEntity(
    //   id: DateTime.now().toString(), // Temporary ID
    //   conversationId: event.conversationId,
    //   senderId: userId,
    //   content: event.content,
    //   createdAt: DateTime.now(),
    // );
    // _messages.add(messageEntity);

    // // Emit the updated state
    // emit(ChatLoadedState(List.from(_messages)));
  }

  Future<void> _onReceiveMessages(
      ReceiveMessageEvent event, Emitter<ChatState> emit) async {
    print("step2 - receive event called");
    print(event.message);
    final message = MessageEntity(
      id: event.message['id'],
      conversationId: event.message['conversation_id'],
      senderId: event.message['sender_id'],
      content: event.message['content'],
      createdAt: (
          event.message['created_at']), // Assuming 'createdAt' is a string
    );

    // Add the received message to the list
    _messages.add(message);

    // Emit the updated state to trigger a UI update
    emit(ChatLoadedState(List.from(_messages)));
  }
}
