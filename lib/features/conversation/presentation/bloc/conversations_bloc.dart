import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/socket_service.dart';
import 'package:messenger/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:messenger/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:messenger/features/conversation/presentation/bloc/conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();

  ConversationsBloc({required this.fetchConversationsUseCase})
      : super(ConversationsInitial()) {
    on<FetchConversations>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
   try
   { _socketService.socket.on('conversationUpdated', _onConversationUpdated);}
    catch (e) {
      print("Error initializing socket listeners: $e");

    
    }
  }

  Future<void> _onFetchConversations(
      FetchConversations event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationsUseCase();
      emit(ConversationsLoaded(conversations));
    } catch (error) {
      emit(ConversationsError('Failed to load conversations'));
    }
  }

  void _onConversationUpdated( data) {
    add(FetchConversations());
  }
}
